part of '../splash.dart';

class LogoViewModel extends ChangeNotifier {
  Future<String> getNextRoute() async {
    // ⏳ Logo display time
    await Future.delayed(const Duration(seconds: 10));

    final prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getBool('first_run') ?? true;
    final int? userId = prefs.getInt('user_id');

    if (isFirstRun) {
      await prefs.setBool('first_run', false);
      return '/splash';
    }

    return (userId != null) ? '/home' : '/login';
  }
}