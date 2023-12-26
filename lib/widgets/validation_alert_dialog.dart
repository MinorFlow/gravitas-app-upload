import 'package:flutter/material.dart';

class ValidationAlertDialog extends StatefulWidget {
  const ValidationAlertDialog({super.key, required this.title, required this.desc});

  final String title, desc;

  @override
  State<ValidationAlertDialog> createState() => _ValidationAlertDialogState();
}

class _ValidationAlertDialogState extends State<ValidationAlertDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.desc),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('확인')
        )
      ],
    );
  }
}