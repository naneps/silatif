import 'package:get/get.dart';
import 'package:silatif/app/services/firebase/question_stream_service.dart';

import '../controllers/question_controller.dart';

class QuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionController>(
      () => QuestionController(),
    );
    Get.lazyPut<QuestionStreamService>(() => QuestionStreamService());
  }
}
