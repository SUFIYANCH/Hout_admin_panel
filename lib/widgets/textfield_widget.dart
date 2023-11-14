import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hinttext;
  final TextEditingController? controller;
  final double width;
  const CustomTextField({
    super.key,
    required this.hinttext,
    required this.controller,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hinttext,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
