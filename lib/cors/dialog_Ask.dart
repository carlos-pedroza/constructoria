import 'package:flutter/material.dart';

class DialogAsk {
  static void show({required BuildContext context, required String title, required Widget content, required void Function() onYes, required void Function() onNo}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: const Text('No'), 
              onPressed: () {
                onNo();
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              child: const Text('Sí'), 
              onPressed: () {
                onYes();
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
  }

  static void confirm({required BuildContext context, required String title, required Widget content, String? labelYes, String? labelNo, required void Function() onYes, required void Function() onNo}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text(labelNo ?? 'No'), 
              onPressed: () {
                onNo();
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              child: Text(labelYes ?? 'Sí'), 
              onPressed: () {
                onYes();
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
  }

  static void confirmNoDismissible({required BuildContext context, required String title, required Widget content, required void Function() onYes, required void Function() onNo}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: const Text('No'), 
              onPressed: () {
                Navigator.of(context).pop();
                onNo();
              }
            ),
            TextButton(
              child: const Text('Sí'), 
              onPressed: () {
                Navigator.of(context).pop();
                onYes();
              }
            ),
          ],
        );
      }
    );
  }

  static void confirm2({required BuildContext context, required String title, required Widget content, required void Function() onYes, required void Function() onNo}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: const Text('No'), 
              onPressed: () {
                onNo();
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              child: const Text('Sí'), 
              onPressed: () {
                onYes();
              }
            ),
          ],
        );
      }
    );
  }

  static void simple({required BuildContext context, required String title, required Widget content, required Function onOk, String? label, Function? onThen}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text(label??'Aceptar'), 
              onPressed: () {
                onOk();
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    ).then((_) {
      onThen?.call();
    });
  }

  static void simpleNoDissmiable({required BuildContext context, required String title, required Widget content, required Function onOk, String? label, Function? onThen}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text(label??'Aceptar'), 
              onPressed: () {
                onOk();
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    ).then((_) {
      onThen?.call();
    });
  }
}