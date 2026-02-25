part of '../setting.dart';

  void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.emerald,
        title: const Text("About Qasas Divine Tales"),
        content: const Text(
          "Qasas Divine Tales is an educational app with bilingual support (English & Urdu). "
          "Premium users can access full stories and offline downloads.",
        ),
        actions: [
          TextButton(
            child: const Text("Close", style: TextStyle(color: AppColors.gold)),
            onPressed: () => context.pop(context),
          ),
        ],
      ),
    );
  }