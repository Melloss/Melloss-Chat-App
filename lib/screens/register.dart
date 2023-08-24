import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/circular_button.dart';
import '../widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showLoading = false;
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String emailError = '';
  String passwordError = '';

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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTextField(context, emailController, 'Email...',
                onChanged: (value) {
              emailError = '';
              if (!value.isEmail) {
                emailError = 'Email is Not Valid';
              }
              if (value.isEmpty) {
                emailError = 'Email is Empty';
              }
            },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                errorText: emailError == '' ? null : emailError),
            buildTextField(context, passwordController, 'Password...',
                onChanged: (value) {
              passwordError = '';

              if (value.length < 6) {
                passwordError =
                    'Password must be greater than or Equal to 6 character';
              }
              if (value.isEmpty) {
                passwordError = 'Password is Empty';
              }
            },
                textAlign: TextAlign.center,
                errorText: passwordError == '' ? null : passwordError),
            const SizedBox(height: 40),
            showLoading == true
                ? const CircularProgressIndicator()
                : buildCircularButton(Colors.blueAccent, "Register", () async {
                    final email = emailController.text;
                    final password = passwordController.text;
                    try {
                      setState(() {
                        showLoading = true;
                      });
                      if (email.isEmail &&
                          email.isNotEmpty &&
                          password.length > 6) {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser.additionalUserInfo!.isNewUser) {
                          final pref = await SharedPreferences.getInstance();
                          pref.setBool('isLoggedBefore', true);
                          Get.offNamed('/chat');
                          emailController.text = '';
                          passwordController.text = '';
                        } else {
                          //
                        }
                      }
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
                    }
                    setState(() {
                      showLoading = false;
                    });
                  })
          ],
        ),
      ),
    );
  }
}
