import 'package:flutter/material.dart';
import 'package:melloss_chat_app/screens/chat.dart';
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTextField(context, emailController, 'Email...',
                onChanged: (value) {},
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress),
            buildTextField(context, passwordController, 'Password...',
                onChanged: (value) {}, textAlign: TextAlign.center),
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
                          Get.to(() => const Chat());
                          emailController.text = '';
                          passwordController.text = '';
                        } else {
                          //
                        }
                      }
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
                  })
          ],
        ),
      ),
    );
  }
}
