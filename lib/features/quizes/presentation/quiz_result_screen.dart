part of '../quizes.dart';

class QuizResultSummaryScreen extends StatefulWidget {
  final int userId;

  const QuizResultSummaryScreen({
    super.key,
    required this.userId,
  });

  @override
  State<QuizResultSummaryScreen> createState() =>
      _QuizResultSummaryScreenState();
}

class _QuizResultSummaryScreenState
    extends State<QuizResultSummaryScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<QuizViewModel>().loadSummary(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<QuizViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Quiz Results")),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: vm.summaries.length,
              itemBuilder: (context, index) {
                final summary = vm.summaries[index];
                return QuizSummaryCard(
                  summary: summary,
                  onPlay: () {
                    context.push(
                      '/quizzes',
                      extra: {
                        'prophetId': summary['prophet_id'],
                        'prophetName':
                            summary['prophet_name_en'],
                        'isPremium': true,
                      },
                    );
                  },
                );
              },
            ),
      bottomNavigationBar: const HomeBottomBar(currentIndex: 0),
    );
  }
}
