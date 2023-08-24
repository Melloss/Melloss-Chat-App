import 'package:flutter/material.dart';
import 'package:get/get.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/melloss_chat_logo_512.png',
              scale: 1.0,
              width: 150,
            ),
          ),
          _buildText(
              'This Mobile Application is developed by \nMikiyas Tekaign (Melloss)'),
          _buildText('Enjoy!!!'),
          const SizedBox(height: 50),
          _buildText('Contact Me',
              scale: 1.3, color: Colors.black.withOpacity(0.6)),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText('Phone Number:'),
              const SizedBox(width: 10),
              const SelectableText(
                '+251917266009',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText('GitHub:'),
              const SizedBox(width: 10),
              const SelectableText(
                'https://github.com/melloss',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText('Telegram:'),
              const SizedBox(width: 10),
              const SelectableText(
                'https://t.me/mikk12',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildText(String s, {double? scale, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        s,
        textAlign: TextAlign.center,
        textScaleFactor: scale ?? 1,
        style: TextStyle(
          fontSize: 18,
          color: color ?? Colors.black45,
        ),
      ),
    );
  }
}
