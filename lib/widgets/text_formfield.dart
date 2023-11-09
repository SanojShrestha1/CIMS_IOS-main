import 'package:flutter/material.dart';
//import 'package:cims/styles/app_colors.dart';
import 'package:cims/styles/text_styles.dart';

class TextFormField extends StatelessWidget {
  final String labelText;
  final bool obsecureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int maxLines;

  const TextFormField(
      {Key? key,
      required this.labelText,
      required this.obsecureText,
      required this.controller,
      required this.maxLines,
      required String? Function(dynamic s) validator, required TextStyle style, required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            labelText,
            style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            color: Colors.black12,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              maxLines: maxLines,
              controller: controller,
              obscureText: obsecureText,
            ),
          ),
        )
      ],
    );
  }
}
