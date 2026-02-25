// // part of '../core.dart';

// // class SubscriptionApi {
// //   static Future<Map> check(int userId) async {
// //     return await ApiClient.get('/subscriptions/check/$userId');
// //   }

// //   static Future<Map> createCheckoutSession(int userId) async {
// //     return await ApiClient.post('/subscriptions/create-session', {
// //       'user_id': userId,
// //     });
// //   }

// //   // ADD THIS METHOD:
// //   static Future<Map> updateSubscription(String sessionId) async {
// //     return await ApiClient.post('/subscriptions/update/$sessionId', {});
// //   }
// // }

// part of '../core.dart';

// class SubscriptionApi {
//   static Future<Map> check(int userId) async {
//     return await ApiClient.get('/subscriptions/check/$userId');
//   }

//   static Future<Map> createCheckoutSession(int userId) async {
//     return await ApiClient.post('/subscriptions/create-session', {
//       'user_id': userId,
//     });
//   }

//   static Future<Map> updateSubscription(String sessionId) async {
//     return await ApiClient.post('/subscriptions/update/$sessionId', {});
//   }
// }


part of '../core.dart';

class SubscriptionApi {
  static Future<Map> check(int userId) async {
    return await ApiClient.get('/subscriptions/check/$userId');
  }

  static Future<Map> createCheckoutSession(int userId, {required String platform}) async {
    return await ApiClient.post('/subscriptions/create-session', {
      'user_id': userId,
    });
  }

  static Future<Map> updateSubscription(String sessionId) async {
    return await ApiClient.post('/subscriptions/update/$sessionId', {});
  }
}
