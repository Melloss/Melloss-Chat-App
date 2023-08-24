import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatBubble extends StatefulWidget {
  final String text;
  final bool isMe;
  final String sender;
  final String id;
  final Timestamp time;
  const ChatBubble(
      {super.key,
      required this.text,
      required this.isMe,
      required this.sender,
      required this.id,
      required this.time});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String getTime() {
    final date = widget.time.toDate();
    late var day = '';
    switch (date.weekday) {
      case 1:
        day = 'Monday';
        break;
      case 2:
        day = 'Tuesday';
        break;
      case 3:
        day = 'Wednesday';
        break;
      case 4:
        day = 'Thursday';
        break;
      case 5:
        day = 'Friday';
        break;
      case 6:
        day = 'Satarday';
        break;
      default:
        day = 'Sunday';
    }
    int hour = date.hour > 12
        ? date.hour - 11
        : date.hour == 0
            ? 12
            : date.hour;
    final minute = (date.minute < 10
        ? date.minute.toString().padLeft(2, '0')
        : date.minute);

    return '$day ${hour < 10 ? hour.toString().padLeft(2, '0') : hour}:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isMe ? const SizedBox.shrink() : _buildProfile(),
        Flexible(
          child: GestureDetector(
            onLongPress: () {
              if (widget.sender != _auth.currentUser!.email) {
                return;
              }
              Get.dialog(
                AlertDialog(
                  title: const Text(
                    'Do you want to delete this message?',
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child:
                          const Text('Cancel', style: TextStyle(fontSize: 15)),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          final documentReference =
                              _fireStore.collection('messages').doc(widget.id);
                          Get.back();
                          await documentReference.delete();
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                      child: const Text('Yes',
                          style: TextStyle(fontSize: 15, color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 10),
              alignment: widget.isMe == true
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10),
                        topLeft: widget.isMe
                            ? const Radius.circular(10)
                            : const Radius.circular(0),
                        topRight: widget.isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(10),
                      ),
                      color: widget.isMe
                          ? Colors.blue.withOpacity(0.8)
                          : const Color.fromARGB(255, 72, 108, 143),
                    ),
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 3,
                        right: widget.isMe ? 8 : 0,
                        left: widget.isMe ? 0 : 8),
                    child: Text(
                      getTime(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        widget.isMe ? _buildProfile() : const SizedBox.shrink(),
      ],
    );
  }

  _buildProfile() {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          'User',
          '${widget.sender} at ${getTime()}',
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 40,
        height: 40,
        margin: EdgeInsets.only(
            left: widget.isMe ? 10 : 0, right: widget.isMe ? 0 : 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: widget.isMe
              ? Colors.blue
              : const Color.fromARGB(255, 72, 108, 143),
        ),
        child: Center(
            child: Text(
          widget.sender.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        )),
      ),
    );
  }
}
