import 'package:flutter/material.dart';

Future yesNoDialog({context, title, content, onYes}) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await onYes();
                  Navigator.of(ctx).pop(true);
                } catch (error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                  Navigator.of(ctx).pop(false);
                }
              },
              child: const Text('Okay'),
            ),
          ]);
    },
  );
}
