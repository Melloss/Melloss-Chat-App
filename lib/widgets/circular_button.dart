import 'package:flutter/material.dart';

buildCircularButton(Color color, String title, Function()? onPressed,
    {Widget? widget}) {
  return Builder(builder: (context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width * 0.6,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: MaterialButton(
        height: 50,
        disabledColor: const Color.fromARGB(255, 224, 212, 212),
        disabledTextColor: Colors.blueGrey,
        clipBehavior: Clip.hardEdge,
        textColor: Colors.white,
        onPressed: onPressed,
        child: title.isEmpty
            ? widget
            : Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
      ),
    );
  });
}
