import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:silatif/app/models/question_model.dart';

class QuestionStreamService extends GetxService {
  final CollectionReference _questionCollection =
      FirebaseFirestore.instance.collection('questions');

  //
  Stream<List<QuestionModel>> getQuestions() {
    return _questionCollection.snapshots().map((event) {
      return event.docs.map((e) {
        return QuestionModel.fromFirestore(
            e as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  /// add new questions
  Future<void> addQuestion(List<Map<String, dynamic>> data) async {
    data.forEach((element) async {
      await _questionCollection.add(element);
    });
  }
}
