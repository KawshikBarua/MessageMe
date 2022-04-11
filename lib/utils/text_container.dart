import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final dynamic text;
  final dynamic sender;
  final double radius = 20;
  const TextContainer({Key? key, required this.text, required this.sender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey.shade300,
      width: size.width,
      alignment: sender == 1 ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        width: text.length > 19 ? size.width / 1.5 : null,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade400,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                blurRadius: 10,
                spreadRadius: 1.5,
                offset: Offset(0, 2))
          ],
          borderRadius: sender == 0
              ? BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                  bottomRight: const Radius.circular(2.3),
                  bottomLeft: Radius.circular(radius))
              : BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                  bottomLeft: const Radius.circular(2.3),
                  bottomRight: Radius.circular(radius)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
    );
  }
}
