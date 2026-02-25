part of '../core.dart';

class StoriesApi {

  /// 🔹 ALL PROPHETS
  static Future<List<Map<String, dynamic>>> getProphets() async {
    final res = await ApiClient.get('/stories/prophets');

    if (res is List) {
      return List<Map<String, dynamic>>.from(res);
    }

    return [];
  }
  
  static Future<List<Map<String, dynamic>>> fetchAllReferences() async {
  final res = await ApiClient.get('/stories/chapter-references');

  if (res is Map && res['references'] is List) {
    return List<Map<String, dynamic>>.from(res['references']);
  }

  return [];
}


  /// 🔹 SHORT STORY (FREE – ALWAYS LIST)
  static Future<List<Map<String, dynamic>>> getShortStory(int prophetId) async {
    final res = await ApiClient.get('/stories/short/$prophetId');

    if (res is List) {
      return List<Map<String, dynamic>>.from(res);
    }

    return [];
  }
static Future<Map<String, dynamic>> getChapterById(
  int chapterId,
  String type, {
  required int storyId,
}) async {
  return await ApiClient.get(
    '/stories/chapter/$chapterId?type=$type&story_id=$storyId',
  );
}



  /// 🔹 FULL STORY (PREMIUM – MAP WITH chapters + audio)
  static Future<Map<String, dynamic>> getFullStory(
      int prophetId, int userId) async {

    final res = await ApiClient.get(
      '/stories/full/$prophetId?user_id=$userId',
    );

    if (res is Map) {
      return Map<String, dynamic>.from(res);
    }

    return {
      'chapters': [],
      'audio': [],
    };
  }
}

