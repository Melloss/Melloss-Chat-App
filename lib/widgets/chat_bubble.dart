import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String text;
  final bool isRight;
  const ChatBubble({super.key, required this.text, required this.isRight});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      alignment:
          widget.isRight == true ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
            topLeft: widget.isRight
                ? const Radius.circular(10)
                : const Radius.circular(0),
            topRight: widget.isRight
                ? const Radius.circular(0)
                : const Radius.circular(10),
          ),
          color: widget.isRight
              ? Colors.blue.withOpacity(0.8)
              : const Color(0xFF222E3A),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
