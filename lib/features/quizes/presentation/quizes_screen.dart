part of '../quizes.dart';

class QuizzesScreen extends StatefulWidget {
  final int prophetId;
  final String prophetName;

  const QuizzesScreen({
    super.key,
    required this.prophetId,
    required this.prophetName,
  });

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<QuizViewModel>().loadQuizzes(widget.prophetId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<QuizViewModel>();

    if (vm.loading) {
      return const Scaffold(
        backgroundColor: AppColors.emerald,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (vm.quizzes.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.emerald,
        appBar: AppBar(title: const Text("Quiz")),
        body: const Center(
          child: Text(
            "No quizzes available",
            style: TextStyle(color: AppColors.white),
          ),
        ),
      );
    }

    final quiz = vm.quizzes[vm.currentIndex];
    final options = List<String>.from(quiz['options_en']);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.prophetName} Quiz"),
        actions: [
          IconButton(
            icon: const Icon(Icons.assessment),
            onPressed: () {
              context.push(
                '/quiz_result',
                extra: {'userId': vm.userId},
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              quiz['question_en'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.emerald,
              ),
            ),
            const SizedBox(height: 20),
            ...options.asMap().entries.map((entry) {
              final idx = entry.key;
              final option = entry.value;

              return QuizOptionCard(
                option: option,
                isSelected: vm.selectedIndex == idx,
                isCorrect: vm.isCorrect,
                onTap: () => vm.checkAnswer(idx),
              );
            }),
            const Spacer(),
            if (vm.isCorrect == true)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: vm.nextQuestion,
                  child: const Text("Next Question"),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomBar(currentIndex: 0),
    );
  }
}
