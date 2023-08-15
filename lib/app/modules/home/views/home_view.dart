import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silatif/app/common/buttons/x_Icon_button.dart';
import 'package:silatif/app/common/shape/rounded_container.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RoundedContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedContainer(
              hasBorder: true,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE0F7FA),
                  Color.fromARGB(255, 119, 239, 255),
                ],
              ),
              padding: const EdgeInsets.all(10),
              borderColor: Colors.grey[300],
              borderWidth: 2,
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width * 0.8,
                    child: Image.asset("assets/images/introduction.png"),
                  ),
                  const Text(
                    "Selama kehidupannya, setiap orang pasti pernah merasa cemas. Rasa cemas dan khawatir adalah hal yang wajar karena ini merupakan respons alami tubuh terhadap ancaman dari luar. Namun, tanpa disadari, rasa cemas ini bisa muncul secara berlebihan sehingga harus diwaspadai karena mungkin saja menandakan suatu penyakit gangguan mental tertentu yang perlu ditangani dengan segera.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            XIconButton(
              icon: Icons.arrow_forward_ios,
              onTap: () {
                Get.toNamed("/question");
              },
            )
          ],
        ),
      ),
    );
  }
}
