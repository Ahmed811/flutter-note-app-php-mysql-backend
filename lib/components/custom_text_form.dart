import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hint;
  final String Function(String?) valid;
  final TextEditingController textEditingController;
  double textEditingPadding;
  CustomTextForm(
      {Key? key,
      required this.hint,
      required this.textEditingController,
      required this.valid,
      this.textEditingPadding = 1.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 1)),
        ),
      ),
    );
  }
}
