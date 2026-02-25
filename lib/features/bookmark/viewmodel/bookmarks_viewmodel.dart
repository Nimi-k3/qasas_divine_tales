part of '../bookmark.dart';

class BookmarksViewModel extends ChangeNotifier {
  final int userId;
  List<Map<String, dynamic>> bookmarks = [];
  bool loading = true;

  BookmarksViewModel({required this.userId}) {
    fetchBookmarks();
  }

  Future<void> fetchBookmarks() async {
    loading = true;
    notifyListeners();
    final data = await BookmarksApi.getAll(userId);
    bookmarks = List<Map<String, dynamic>>.from(data);
    loading = false;
    notifyListeners();
  }

  Future<void> removeBookmark(Map<String, dynamic> b) async {
    if (b['story_id'] == null) return;
    await BookmarksApi.remove(
      userId,
      b['story_id'],
      b['chapter_id'],
      b['story_type'],
    );
    fetchBookmarks();
  }

  Future<Map<String, dynamic>> openChapter(Map<String, dynamic> b) async {
    final chapter = await StoriesApi.getChapterById(
      b['chapter_id'],
      b['story_type'],
      storyId: b['story_id'],
    );

    final chapters = b['story_type'] == 'short'
        ? await StoriesApi.getShortStory(b['story_id'])
        : (await StoriesApi.getFullStory(b['story_id'], userId))['chapters'];

    return {
      'chapter': chapter,
      'chapters': chapters,
      'audio': [],
      'isPremium': b['story_type'] == 'long',
      'references': chapter['references'] ?? [],
      'storyType': b['story_type'],
      'storyId': b['story_id'],
    };
  }
}
