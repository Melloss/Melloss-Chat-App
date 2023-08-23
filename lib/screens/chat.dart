import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:melloss_chat_app/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/uiController.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  late User loggedInUser;
  final sendController = TextEditingController();
  bool isSending = false;
  final uiController = Get.put(UIController());

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
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title:
            const Text("Melloss Chat", style: TextStyle(color: Colors.black54)),
        actions: [
          _buildLogout(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _buildStreamBuilder(),
            _buildChatTextField(),
          ],
        ),
      ),
    );
  }

  _buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _fireStore.collection('messages').orderBy('time').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs.reversed;
            List<ChatBubble> messageBubbles = [];
            for (var message in messages) {
              final messageText = message.data()['text'];
              final messageSender = message.data()['sender'];
              messageBubbles.add(
                ChatBubble(
                  id: message.id,
                  text: messageText,
                  isMe: messageSender == loggedInUser.email,
                  sender: messageSender,
                  time: message.data()['time'],
                ),
              );
            }

            return Expanded(
                child: ListView(
              reverse: true,
              children: messageBubbles,
            ));
          } else {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          }
        }));
  }

  _buildChatTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        onChanged: (text) {
          if (text.isEmpty) {
            setState(() {
              isSending = false;
            });
          }
        },
        controller: sendController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: 'Message',
          suffixIcon: IconButton(
            icon: isSending == true
                ? const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  )
                : const Icon(
                    Icons.send,
                    color: Colors.blue,
                    size: 25,
                  ),
            onPressed: () async {
              if (sendController.text.isNotEmpty) {
                setState(() {
                  isSending = true;
                });
                Map<String, dynamic> message = {
                  'text': sendController.text,
                  'sender': loggedInUser.email,
                  'time': DateTime.now(),
                };
                await _fireStore
                    .collection('messages')
                    .add(message)
                    .whenComplete(() {
                  sendController.text = '';
                  setState(() {
                    isSending = false;
                  });
                }).catchError((error) {
                  setState(() {
                    isSending = false;
                  });
                });
              }
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  _buildLogout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: IconButton(
        onPressed: () {
          Get.dialog(AlertDialog(
            title: const Center(child: Text('Logout')),
            content: const Text('Do you want to Logout?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    final pref = await SharedPreferences.getInstance();
                    pref.setBool('isLoggedBefore', false);
                    await _auth.signOut();
                    Get.to(() => const Welcome());
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ));
        },
        icon: const Icon(
          Icons.logout,
          size: 20,
        ),
      ),
    );
  }
}
