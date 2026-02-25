part of '../core.dart';

class BookmarksApi {

  /// Add or update bookmark (with scroll position)
static Future addOrUpdate({
  required int userId,
  required int storyId,
  required int chapterId,
  required String storyType,
  required int scrollPosition,
}) async {
  final payload = {
    'user_id': userId,
    'story_id': storyId,
    'chapter_id': chapterId,
    'story_type': storyType,
    'scroll_position': scrollPosition,
  };

  print('Bookmark payload: $payload'); // <-- add this line

  return ApiClient.post('/bookmarks/add', payload);
}


 static Future remove(
  int userId,
  int storyId,   // ✅ REQUIRED
  int chapterId,
  String storyType,
) async {
  return ApiClient.post('/bookmarks/remove', {
    'user_id': userId,
    'story_id': storyId,
    'chapter_id': chapterId,
    'story_type': storyType,
  });
}


  /// Check if bookmarked ✅
  static Future<bool> isBookmarked(
    int userId,
    int storyId,              // ✅ new
    int chapterId,
    String storyType,
  ) async {
    final res = await ApiClient.post('/bookmarks/check', {
      'user_id': userId,
      'story_id': storyId,     // ✅ pass storyId
      'chapter_id': chapterId,
      'story_type': storyType,
    });

    return res['is_bookmarked'] == true;
  }

  /// Get all bookmarks
  static Future<List> getAll(int userId) async {
    final res = await ApiClient.get('/bookmarks/$userId');
    return res as List;
  }
}
