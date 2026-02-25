part of '../quizes.dart';

class ProphetsQuizzesViewModel extends ChangeNotifier {
  bool loading = true;
  List<Map<String, dynamic>> prophets = [];

  Future<void> loadProphets() async {
    loading = true;
    notifyListeners();

    final data = await StoriesApi.getProphets();
    prophets = List<Map<String, dynamic>>.from(data);

    loading = false;
    notifyListeners();
  }
}
