import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/circular_button.dart';
import '../widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isValid = false;
  bool showLoading = false;
  bool showPassword = false;
  bool showEye = false;
  final _auth = FirebaseAuth.instance;
  void checkValid() {
    if (emailController.text.isNotEmpty &&
        emailController.text.isEmail &&
        passwordController.text.length > 6) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 5),
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('/about', preventDuplicates: true);
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    size: 25,
                    color: Colors.black38,
                  )),
            ),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 13, 66, 107),
                    fontWeight: FontWeight.w500,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Melloss Chat",
                        curve: Curves.bounceIn,
                        speed: const Duration(milliseconds: 150),
                      ),
                    ],
                  )),
              const SizedBox(height: 50),
              buildTextField(context, emailController, "Email...",
                  onChanged: (value) {
                checkValid();
              }, keyboardType: TextInputType.emailAddress),
              buildTextField(context, passwordController, "Password...",
                  obscure: showPassword ? false : true, onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    showEye = true;
                  });
                } else {
                  setState(() {
                    showEye = false;
                  });
                }
                checkValid();
              },
                  suffix: showEye
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            showPassword == true
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            size: 20,
                          ))
                      : const SizedBox.shrink()),
              const SizedBox(height: 20),
              showLoading
                  ? const CircularProgressIndicator.adaptive()
                  : buildCircularButton(
                      Colors.blueAccent,
                      "Login",
                      isValid
                          ? () async {
                              setState(() {
                                showLoading = true;
                              });
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text);
                                if (!user.user.isBlank!) {
                                  final pref =
                                      await SharedPreferences.getInstance();
                                  pref.setBool('isLoggedBefore', true);
                                  Get.offNamed('/chat');
                                }
                                emailController.text = '';
                                passwordController.text = '';
                                setState(() {
                                  showLoading = false;
                                });
                              } on FirebaseException catch (e) {
                                Get.snackbar(
                                  'Error',
                                  e.message!,
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.black54,
                                  margin: const EdgeInsets.all(10),
                                  duration: const Duration(seconds: 3),
                                );
                                setState(() {
                                  showLoading = false;
                                });
                              } catch (e) {
                                Get.snackbar(
                                  'Error',
                                  e.toString(),
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.black54,
                                  margin: const EdgeInsets.all(10),
                                  duration: const Duration(seconds: 3),
                                );
                                setState(() {
                                  showLoading = false;
                                });
                              }
                            }
                          : null),
              Visibility(
                visible: !showLoading,
                child:
                    buildCircularButton(Colors.lightBlueAccent, "Register", () {
                  Get.toNamed('/register');
                }),
              ),
            ],
          ),
        ));
  }
}
