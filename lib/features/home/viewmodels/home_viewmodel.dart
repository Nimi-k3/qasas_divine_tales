part of '../home.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isPremium = false;
  bool get isPremium => _isPremium;

  HomeViewModel() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool('is_premium') ?? false;
    notifyListeners();
  }
}
