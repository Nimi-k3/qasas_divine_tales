part of '../subscription.dart';

// class SubscriptionViewModel extends ChangeNotifier {
//   final int userId;
//   bool loading = true;
//   bool isPremium = false;
//   String expiryDate = '';

//   SubscriptionViewModel({required this.userId}) {
//     checkSubscription();
//   }

//   Future<void> checkSubscription() async {
//     loading = true;
//     notifyListeners();

//     try {
//       final data = await SubscriptionApi.check(userId);
//       isPremium = data['is_premium'] ?? false;
//       expiryDate = data['subscription_expiry'] ?? '';
//     } catch (e) {
//       debugPrint("Subscription check failed: $e");
//     }

//     loading = false;
//     notifyListeners();
//   }
// }
class SubscriptionViewModel extends ChangeNotifier {
  final int userId;
  bool loading = true;
  bool isPremium = false;
  String expiryDate = '';

  SubscriptionViewModel({required this.userId}) {
    checkSubscription();
  }

  Future<void> checkSubscription() async {
    loading = true;
    notifyListeners();

    try {
      final data = await SubscriptionApi.check(userId);
      isPremium = data['is_premium'] ?? false;

      final expiry = data['subscription_expiry'];
      if (expiry != null && expiry.isNotEmpty) {
        // Format as readable date
        final dt = DateTime.parse(expiry).toLocal();
        expiryDate = "${dt.day}/${dt.month}/${dt.year}";
      } else {
        expiryDate = '';
      }
    } catch (e) {
      debugPrint("Subscription check failed: $e");
    }

    loading = false;
    notifyListeners();
  }

  Future<void> subscribe() async {
    final res = await SubscriptionApi.createCheckoutSession(userId, platform: kIsWeb ? "web" : "mobile",);
    final url = res['url'];
    if (url != null) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
