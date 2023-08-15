import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:silatif/app/common/shape/rounded_container.dart';
import 'package:silatif/app/common/ui/empty_state_view.dart';
import 'package:silatif/app/common/ui/x_appbar.dart';
import 'package:silatif/app/common/utils.dart';
import 'package:silatif/app/modules/question/widgets/card_question.dart';
import 'package:silatif/app/themes/theme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../controllers/question_controller.dart';

class QuestionView extends GetView<QuestionController> {
  const QuestionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RoundedContainer(
          child: Column(
            children: [
              XAppBar(
                rightIcon: Icons.close,
                title: "Pertanyaan ",
                hasRightIcon: true,
              ),
              RoundedContainer(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(() {
                  return Visibility(
                    visible: controller.totalQuestion.value > 0 ? true : false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pertanyaan ${controller.currentQuestion} dari ${controller.totalQuestion}",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 10),
                        StepProgressIndicator(
                          totalSteps: controller.totalQuestion.value > 0
                              ? controller.totalQuestion.value
                              : 1,
                          currentStep: controller.currentQuestion.value > 0
                              ? controller.currentQuestion.value
                              : 1,
                          size: 15,
                          selectedColor: ThemeApp.primaryColor,
                          unselectedColor: ThemeApp.lightColor,
                          roundedEdges: const Radius.circular(5),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Expanded(
                child: RoundedContainer(
                  width: Get.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  hasBorder: true,
                  child: StreamBuilder(
                    stream: controller.questionService.getQuestions(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Utils.loadingWidget(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Center(
                              child: EmptyStateView(
                            icon: MdiIcons.informationOutline,
                            label: "Belum ada pertanyaan",
                          ));
                        }
                        // controller.questions.value = snapshot.data as List;
                        // controller.totalQuestion.value = snapshot.data!.length;
                        return SwipableStack(
                          controller: controller.swipableController,
                          itemCount: snapshot.data!.length,
                          swipeAnchor: SwipeAnchor.top,
                          swipeAssistDuration:
                              const Duration(milliseconds: 500),
                          onWillMoveNext: (index, swipeDirection) {
                            final allowAction = [
                              SwipeDirection.left,
                              SwipeDirection.right,
                            ];
                            //when first question, only allow swipe right

                            if (index == 0) {
                              allowAction.remove(SwipeDirection.left);
                            } else if (index ==
                                controller.totalQuestion.value - 1) {
                              allowAction.remove(SwipeDirection.right);
                            }

                            return allowAction.contains(swipeDirection);
                          },
                          rewindAnimationCurve: Curves.bounceInOut,
                          cancelAnimationCurve: Curves.bounceInOut,
                          onSwipeCompleted: (index, swipeDirection) {
                            if (swipeDirection == SwipeDirection.left) {
                              controller.questions[index].selectedOption = 0;
                            } else if (swipeDirection == SwipeDirection.right) {
                              controller.questions[index].selectedOption = 1;
                            }
                            controller.currentQuestion.value = index + 2;
                            controller.totalAnswered.value = index + 1;
                            if (index == controller.totalQuestion.value - 1) {
                              // Get.toNamed("/result"); v
                            }
                          },
                          builder: (context, swipeProperty) {
                            // print(swipeProperty.direction);
                            return CardQuestion(
                              index: swipeProperty.index,
                              question: snapshot.data![swipeProperty.index],
                            );
                          },
                          allowVerticalSwipe: false,
                          stackClipBehaviour: Clip.none,
                          dragStartDuration: const Duration(milliseconds: 500),
                          hitTestBehavior: HitTestBehavior.translucent,
                          dragStartCurve: Curves.bounceInOut,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
              RoundedContainer(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                hasBorder: true,
                height: 50,
                width: Get.width,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.swipableController.rewind(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                          );
                        },
                        child: const Text(
                          "Kembali",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.swipableController.next(
                            swipeDirection: SwipeDirection.right,
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                          );
                          // controller.add();
                        },
                        child: const Text(
                          "Lanjut",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
