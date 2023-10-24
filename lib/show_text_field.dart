// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ShowTextField extends StatefulWidget {
  final String value;
  const ShowTextField({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<ShowTextField> createState() => _ShowTextFieldState();
}

class _ShowTextFieldState extends State<ShowTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: false,
    );
  }
}
