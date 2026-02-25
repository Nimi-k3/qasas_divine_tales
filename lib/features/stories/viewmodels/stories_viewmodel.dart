part of '../stories.dart';

class StoriesViewModel extends ChangeNotifier {
  bool loading = true;
  bool isPremium = false;

  List shortChapters = [];
  List longChapters = [];
  List audio = [];

  final int storyId;
  final int userId;

  StoriesViewModel({required this.storyId, required this.userId}) {
    _loadUserAndStories();
  }

  Future<void> _loadUserAndStories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isPremium = prefs.getBool('is_premium') ?? false;

      shortChapters = await StoriesApi.getShortStory(storyId);

      if (isPremium) {
        final res = await StoriesApi.getFullStory(storyId, userId);
        longChapters = res['chapters'] ?? [];
        audio = res['audio'] ?? [];
      }
    } catch (e) {
      debugPrint('Story load error: $e');
    }

    loading = false;
    notifyListeners();
  }
}
