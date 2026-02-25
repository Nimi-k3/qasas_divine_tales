part of '../references.dart';

class ReferencesViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> references = [];
  bool loading = true;
  String lang = 'en';

  Future<void> loadReferences() async {
    loading = true;
    notifyListeners();

    final data = await StoriesApi.fetchAllReferences();
    references = data;
    loading = false;
    notifyListeners();
  }

  void toggleLanguage() {
    lang = lang == 'en' ? 'ur' : 'en';
    notifyListeners();
  }

  String getReferenceText(Map<String, dynamic> ref) {
    return lang == 'en' ? ref['source_en'] ?? '' : ref['source_ur'] ?? '';
  }
}
