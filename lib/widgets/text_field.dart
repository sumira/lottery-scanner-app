import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        obscureText: isPass,
        controller: textEditingController,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 18,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black45,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color.fromARGB(255, 212, 224, 255),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
