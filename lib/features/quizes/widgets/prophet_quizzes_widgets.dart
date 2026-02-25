part of '../quizes.dart';

class ProphetQuizTile extends StatelessWidget {
  final Map<String, dynamic> prophet;

  const ProphetQuizTile({super.key, required this.prophet});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.quiz_outlined, color: AppColors.gold),
      title: Text(
        prophet['name_en'],
        style: const TextStyle(
          color: AppColors.emerald,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.darkEmerald),
      onTap: () {
        context.push('/quizzes', extra: {
          'prophetId': prophet['id'],
          'prophetName': prophet['name_en'],
          'isPremium': true, // could check from prefs
        });
      },
    );
  }
}
