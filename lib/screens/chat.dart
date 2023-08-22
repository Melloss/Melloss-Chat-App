import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:melloss_chat_app/widgets/circular_button.dart';
import '../widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  late User loggedInUser;
  final key = GlobalKey<ScaffoldState>();
  final sendController = TextEditingController();

  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  void getCurrentUser() async {
    try {
      User user = _auth.currentUser!;
      if (!user.isBlank!) {
        loggedInUser = user;
      }
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
  }

  @override
  void dispose() {
    sendController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
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
          centerTitle: true,
          title: const Text("Melloss Chat",
              style: TextStyle(color: Colors.black54)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () {
                  key.currentState?.openEndDrawer();
                },
                icon: const Icon(Icons.person_3_rounded),
              ),
            ),
          ],
        ),
        endDrawer: _buildEndDrawer(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              _buildStreamBuilder(),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: sendController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Say Hello to Melloss',
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 20,
                        ),
                        onPressed: () async {
                          Map<String, dynamic> message = {
                            'text': sendController.text,
                            'sender': loggedInUser.email,
                          };
                          await _fireStore.collection('messages').add(message);
                          sendController.text = '';
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _buildEndDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const Center(
              child: Text(
            'Account Info',
            textScaleFactor: 1.5,
          )),
          const SizedBox(height: 20),
          Text(
            loggedInUser.email!,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          buildCircularButton(
            Colors.blueAccent,
            'Log Out',
            () async {
              await _auth.signOut();
              Get.back();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  _buildStreamBuilder() {
    return StreamBuilder(
        stream: _fireStore.collection('messages').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs.reversed;
            List<ChatBubble> messageBubbles = [];
            for (var message in messages) {
              final messageText = message.data()['text'];
              final messageSender = message.data()['sender'];
              messageBubbles.add(
                ChatBubble(
                    text: messageText,
                    isRight: messageSender == loggedInUser.email),
              );
            }
            return Expanded(
                child: ListView(
              reverse: true,
              children: messageBubbles,
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}
