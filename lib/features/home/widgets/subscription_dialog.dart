part of '../home.dart';
void _showSubscriptionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.darkEmerald, // Match screen background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.workspace_premium, color: AppColors.gold),
          SizedBox(width: 10),
          Text("Premium Content", style: TextStyle(color: AppColors.white)),
        ],
      ),
      content: const Text(
        "Knowledge is a journey! Subscribe to our premium plan to take quizzes and test your learning.",
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Maybe Later", style: TextStyle(color: AppColors.white)),
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              context.push('/subscription'); // Go to subscription screen
            },
            child: const Text("Subscribe Now"),
          ),
        ),

          ],
        )
        
      ],
    ),
  );
}