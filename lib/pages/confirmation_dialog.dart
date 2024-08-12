import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(BuildContext context, String language) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Language Selection'),
        content: Text(
            'Are you sure you want to select "$language" as your language?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false if canceled
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Return true if confirmed
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
