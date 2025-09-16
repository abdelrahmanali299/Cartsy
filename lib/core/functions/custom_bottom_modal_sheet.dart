import 'package:flutter/material.dart';

customBottomModalSheet({required BuildContext context, required Widget child}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return child;
    },
  );
}
