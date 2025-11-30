import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/common/widgets/custom_color.dart';
import 'package:lustless_hichim890/features/auth/screen/signin_register_screen.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/field_controller.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/scoreboard_controller.dart';

class FinalQuestion extends StatelessWidget {
  const FinalQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ScoreboardController());
    final FieldController fieldController = Get.put(FieldController());
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    // Create TextEditingControllers with initial values from FieldController
    final TextEditingController nameController = TextEditingController(text: fieldController.name.value);
    final TextEditingController ageController = TextEditingController(text: fieldController.age.value);

    // Listen to changes and update FieldController
    nameController.addListener(() {
      fieldController.validateName(nameController.text);
    });
    ageController.addListener(() {
      fieldController.validateAge(ageController.text);
    });

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: getContainerGradient()),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.13),
                Center(
                  child: Text(
                    'Finally',
                    style: getTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    'A title more about you',
                    style: getTextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.050),
                Text(
                  'Your Name',
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff071123),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xff133663), width: 0.5),
                  ),
                  child: TextField(
                    controller: nameController, // Use persistent controller
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Your first name',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF).withValues(alpha: 0.8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff133663),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff133663),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff133663),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                Text(
                  'Your Age',
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff071123),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xff133663), width: 0.5),
                  ),
                  child: TextField(
                    controller: ageController, // Use persistent controller
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Your age',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF).withValues(alpha: 0.8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff133663),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff133663),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff133663),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                InkWell(

                  onTap: () {
                    if (fieldController.canStarted()) {
                      Get.off(() => SigninRegisterScreen());
                    } else {
                      EasyLoading.showError('Please fill the both field');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: getTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff1C1C1C),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}