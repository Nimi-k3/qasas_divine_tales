part of '../quizes.dart';

class QuizViewModel extends ChangeNotifier {
  bool loading = true;
  int userId = 0;
  bool isPremium = false;

  List<Map<String, dynamic>> quizzes = [];
  int currentIndex = 0;
  int? selectedIndex;
  bool? isCorrect;

  List<Map<String, dynamic>> summaries = [];

  /// Load quizzes for a prophet
  Future<void> loadQuizzes(int prophetId) async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id') ?? 0;
    isPremium = prefs.getBool('is_premium') ?? false;

    if (!isPremium) {
      quizzes = [];
      loading = false;
      notifyListeners();
      return;
    }

    final data = await QuizApi.getQuizzesWithProgress(userId, prophetId);
    quizzes = List<Map<String, dynamic>>.from(data['quizzes']);
    loading = false;
    notifyListeners();
  }

  /// Check answer
  Future<void> checkAnswer(int optionIndex) async {
    final quiz = quizzes[currentIndex];
    final correctIndex = quiz['correct_option'];
    final correct = optionIndex == correctIndex;

    selectedIndex = optionIndex;
    isCorrect = correct;
    notifyListeners();

    if (correct) {
      await QuizApi.updateProgress(userId, quiz['id'], true);
    }
  }

  /// Next question
  void nextQuestion() {
    if (currentIndex < quizzes.length - 1) {
      currentIndex++;
      selectedIndex = null;
      isCorrect = null;
      notifyListeners();
    }
  }

  /// Load summary
  Future<void> loadSummary(int userId) async {
    final data = await QuizApi.getProgressSummary(userId);
    summaries = List<Map<String, dynamic>>.from(data);
    loading = false;
    notifyListeners();
  }
}
