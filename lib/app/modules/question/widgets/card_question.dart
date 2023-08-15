import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silatif/app/common/shape/rounded_container.dart';
import 'package:silatif/app/common/utils.dart';
import 'package:silatif/app/models/question_model.dart';
import 'package:silatif/app/themes/theme.dart';

class CardQuestion extends StatelessWidget {
  final QuestionModel question;
  final int index;

  const CardQuestion({required this.question, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedContainer(
            hasBorder: true,
            width: 40,
            height: 40,
            radiusType: RadiusType.diagonal1,
            color: ThemeApp.primaryColor,
            child: Center(
              child: Text(
                "${index + 1}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          RoundedContainer(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  question.text!,
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
                const SizedBox(height: 10),
                RoundedContainer(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    maxHeight: 500,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: question.options!.length,
                    itemBuilder: (context, optionIndex) {
                      final option = question.options![optionIndex];
                      final Rx weight = question.weights![optionIndex].obs;
                      return RoundedContainer(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        hasBorder: true,
                        child: Obx(() {
                          return RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            value: weight.value,
                            activeColor: ThemeApp.primaryColor,
                            groupValue: question.selectedOption,
                            title: Text(
                              option,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onChanged: (value) {
                              question.selectedOption = value as int;
                              question.isAnswered!.value = true;
                              print(question.selectedOption);
                            },
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
