part of '../auth.dart';

void showAuthSnackBar(BuildContext context, String message, {bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.redAccent : Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
