import 'package:get/get.dart';
import 'package:silatif/app/models/question_model.dart';
import 'package:silatif/app/services/firebase/question_stream_service.dart';
import 'package:swipable_stack/swipable_stack.dart';

class QuestionController extends GetxController {
  //TODO: Implement QuestionController
  RxInt currentQuestion = 1.obs;
  RxInt totalQuestion = 1.obs;
  RxInt totalAnswered = 0.obs;
  final questionService = Get.find<QuestionStreamService>();
  final swipableController = SwipableStackController();

  RxList<QuestionModel> questions = <QuestionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      questions.bindStream(questionService.getQuestions());
      ever(questions, (_) {
        print('Questions: ${questions.length}');
        totalQuestion.value = questions.length;
        currentQuestion.value = 1;
      });
    } catch (error) {
      print('Error fetching questions: $error');
    }
  }

  void nextQuestion() {
    if (currentQuestion.value < totalQuestion.value) {
      currentQuestion.value++;
    }
  }

  void prevQuestion() {
    if (currentQuestion.value > 1) {
      currentQuestion.value--;
    }
  }

  void add() async {
    await questionService.addQuestion([
      {
        "text":
            "Adanya perasaan cemas, seperti: firasat buruk, takut akan pikiran sendiri, mudah tersinggung dan mudah emosi.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya ketegangan, seperti: merasa tegang, lesu, mudah terkejut, tidak dapat istirahat dengan tenang, mudah menangis, gemetar dan gelisah.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya ketakutan pada gelap, ditinggal sendiri, pada orang asing, pada kerumunan banyak orang.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gangguan tidur seperti: sukar memulai tidur, terbangun malam hari, mimpi buruk dan mimpi yang menakutkan.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gangguan kecerdasan, seperti: daya ingat buruk, sulit berkonsentrasi, sering bingung, banyak pertimbangan.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya perasaan depresi, seperti: kehilangan minat, sedih, berkurangnya kesukaan pada hobi, perasaan berubah-ubah.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gejala gangguan somatik (otot-otot), seperti: nyeri otot, kaku, kedutan otot, gigi gemertak dan suara tak stabil.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gejala gangguan sensorik, seperti: telinga berdengung, penglihatan kabur, muka merah dan pucat, merasa lemah.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gejala gangguan kardiovaskuler, seperti: denyut nad cepat, berdebar-debar, nyeri dada, rasa lemah seperti mau pingsan.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gejala gangguan pernafasan, seperti: rasa tertekan di dada, perasaan tercekik, merasa nafas pendek/sesak dan sering menarik nafas panjang",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gejala gangguan gastrointestinal, seperti: Sulit menelan, Mual muntah, Perut terasa penuh dan kembung dan Nyeri lambung sebelum makan dan sesudah",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gejala gangguan urogenitalia, seperti: Sering kencing dan Tidak dapat menahan kencing.",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Adanya gejala gangguan otonom, seperti: Mulut kering, Muka kering, Mudah berkeringat, Sakit kepala, Bulu roma berdiri",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      },
      {
        "text":
            "Apakah saat ini, anda merasakan gelisah, tidak terang, mengerutkan dahi muka tegang dan nafas pendek dan cepat",
        "options": [
          "Tidak ada (Tidak ada gejala sama sekali)",
          "Ringan (Satu gejala dari pilihan yang ada)",
          "Sedang (Separuh dari gejala yang ada)",
          "Berat (Lebih dari separuh dari gejala yang ada)",
          "Sangat berat (Semua gejala ada)"
        ],
        "weights": [0, 1, 2, 3, 4]
      }
    ]);
  }
}
