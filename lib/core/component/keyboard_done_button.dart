import 'package:flutter/material.dart';

class KeyboardAwareDoneButton extends StatelessWidget {
  final FocusNode focusNode;

  const KeyboardAwareDoneButton({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Visibility(
      visible:keyboardVisible ,
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                focusNode.unfocus();
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
