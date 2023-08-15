import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuestionModel {
  String? id;
  String? text;
  List<String>? options;
  List<int>? weights;
  int? selectedOption; // Add this property
  RxBool? isAnswered = false.obs; // Add this property

  QuestionModel({
    this.id,
    this.text,
    this.options,
    this.weights,
    this.selectedOption,
    this.isAnswered,
  });

  // ... rest of the class ...

  // You can update this method to initialize selectedOption if needed
  QuestionModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    id = doc.id;
    text = data['text'];
    options = data['options'].cast<String>();
    weights = data['weights'].cast<int>();
    selectedOption = null; // Initialize selectedOption
  }

  // ... rest of the class ...
}
