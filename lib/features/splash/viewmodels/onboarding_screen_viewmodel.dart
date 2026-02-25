// part of '../splash.dart';
// class OnboardingViewModel extends ChangeNotifier {
//   final PageController controller = PageController();
//   int currentIndex = 0;

//   final List<Map<String, String>> splashData = [
//     {
//       "image": "assets/splash/splash1.png",
//       "title": "Stories of Guidance",
//       "desc": "Explore timeless tales of the Prophets, filled with wisdom, lessons, and guidance for life.",
//     },
//     {
//       "image": "assets/splash/splash2.png",
//       "title": "Learn & Reflect",
//       "desc": "Understand moral values, reflect on divine teachings, and grow spiritually through meaningful stories.",
//     },
//     {
//       "image": "assets/splash/splash3.png",
//       "title": "Inspiration for Every Age",
//       "desc": "Unlock detailed stories, audio narration, and offline access for a complete learning experience.",
//     },
//   ];

//   void updateIndex(int index) {
//     currentIndex = index;
//     notifyListeners();
//   }

//   bool get isLastPage => currentIndex == splashData.length - 1;

//   void handleNext(VoidCallback onFinish) {
//     if (isLastPage) {
//       onFinish();
//     } else {
//       controller.nextPage(
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
  

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }

part of '../splash.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> splashData = [
    {
      "image": "assets/splash/splash1.png",
      "title": "Stories of Guidance",
      "desc": "Explore timeless tales of the Prophets, filled with wisdom, lessons, and guidance for life.",
    },
    {
      "image": "assets/splash/splash2.png",
      "title": "Learn & Reflect",
      "desc": "Understand moral values, reflect on divine teachings, and grow spiritually through meaningful stories.",
    },
    {
      "image": "assets/splash/splash3.png",
      "title": "Inspiration for Every Age",
      "desc": "Unlock detailed stories, audio narration, and offline access for a complete learning experience.",
    },
  ];

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool get isLastPage => currentIndex == splashData.length - 1;

  void handleNext(VoidCallback onFinish) {
    if (isLastPage) {
      onFinish();
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  /// ✅ Only persistence logic here
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_run_done', true);
    AuthService.setFirstRun(false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
