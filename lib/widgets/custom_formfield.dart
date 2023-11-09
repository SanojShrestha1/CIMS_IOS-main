import 'package:flutter/material.dart';
//import 'package:cims/styles/app_colors.dart';
import 'package:cims/styles/text_styles.dart';

class CustomFormField extends StatefulWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String?)? validator;

  const CustomFormField({
    Key? key,
    required this.headingText,
    required this.hintText,
    required this.obsecureText,
    required this.suffixIcon,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    required this.maxLines,
    this.validator,
    required bool isEmpty,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _isEmpty = false;

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
            widget.headingText,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isEmpty ? Colors.red : Color.fromARGB(255, 232, 244, 240),
              width: 1,
            ),
            color: Color.fromARGB(255, 112, 27, 22),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              maxLines: widget.maxLines,
              controller: widget.controller,
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              obscureText: widget.obsecureText,
              onChanged: (value) {
                setState(() {
                  _isEmpty = value.trim().isEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: KTextStyle.textFieldHintStyle,
                border: InputBorder.none,
                suffixIcon: widget.suffixIcon,
              ),
            ),
          ),
        ),
        if (_isEmpty)
          Container(
            margin: const EdgeInsets.only(left: 20, top: 4),
            child: const Text(
              'Field cannot be empty',
              style: TextStyle(
                color: Color.fromARGB(255, 230, 38, 24),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}