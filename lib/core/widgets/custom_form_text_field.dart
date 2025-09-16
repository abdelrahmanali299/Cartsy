import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.isSecure = false,
    this.onSaved,
    this.suffexIcon,
    this.maxLines = 1,
  });
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffexIcon;
  final Function(String?)? onChanged;
  final bool isSecure;
  final int? maxLines;
  final Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: onSaved,

      onChanged: onChanged,

      cursorColor: Colors.blue,
      obscureText: isSecure,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffexIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),

          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
