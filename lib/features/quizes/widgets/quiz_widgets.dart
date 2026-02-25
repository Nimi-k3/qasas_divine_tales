part of '../quizes.dart';

class QuizOptionCard extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback onTap;

  const QuizOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey.shade300;
    if (isSelected) {
      borderColor = isCorrect == true ? AppColors.gold : AppColors.error;
    }

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(option),
        onTap: onTap,
      ),
    );
  }
}

class QuizSummaryCard extends StatelessWidget {
  final Map<String, dynamic> summary;
  final VoidCallback onPlay;

  const QuizSummaryCard({super.key, required this.summary, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    final prophetName = summary['prophet_name_en'] ?? 'Unknown Prophet';
    final completedCount = summary['completed_count'] ?? 0;
    final totalCount = summary['total_count'] ?? 0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.book, color: AppColors.gold),
        title: Text(prophetName),
        subtitle: Text("Correct: $completedCount/$totalCount"),
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: onPlay,
        ),
      ),
    );
  }
}
