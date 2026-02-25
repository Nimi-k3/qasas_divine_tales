part of '../core.dart';

class QuizApi {
  /// Get quizzes with progress for a user (optionally filter by prophet)
  static Future<Map<String, dynamic>> getQuizzesWithProgress(int userId, int prophetId) async {
    return await ApiClient.get('/quizzes/quizzes_with_progress?user_id=$userId&prophet_id=$prophetId');
  }

  /// Get quiz progress for a user
  static Future<List<Map<String, dynamic>>> getProgress(int userId) async {
    final res = await ApiClient.get('/quizzes/quiz_progress?user_id=$userId');
    return List<Map<String, dynamic>>.from(res);
  }

  /// Get progress summary for all prophets 
  static Future<List<Map<String, dynamic>>> getProgressSummary(int userId) async
   {
     final res = await ApiClient.get('/quizzes/progress_summary?user_id=$userId'); 
     return List<Map<String, dynamic>>.from(res); 
    }

  /// Update quiz progress (mark quiz as passed or not)
  static Future<Map<String, dynamic>> updateProgress(int userId, int quizId, bool passed) async {
    return await ApiClient.post('/quizzes/quiz_progress', {
      'user_id': userId,
      'quiz_id': quizId,
      'passed': passed,
    });
  }
}
