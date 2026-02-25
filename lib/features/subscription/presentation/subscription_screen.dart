// part of '../subscription.dart';

// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({super.key});

//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }

// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   int userId = 0;
//   bool isVerifying = false;
//   bool updateCalled = false;

//  @override
// void initState() {
//   super.initState();
//   _loadUser();
//   _listenStripeRedirect();
// }

// Future<void> _loadUser() async {
//   final prefs = await SharedPreferences.getInstance();
//   userId = prefs.getInt('user_id') ?? 0;

//   if (!mounted) return;
//   setState(() {});
// }




// void _listenStripeRedirect() async {
//   // For when app is already open
//   uriLinkStream.listen((Uri? uri) {
//     if (uri == null) return;
//     if (uri.scheme == "stripe-success") {
//       final sessionId = uri.queryParameters['session_id'] ?? '';
//       if (sessionId.isNotEmpty) {
//         _verifyAndUpdateSubscription(sessionId);
//       }
//     } else if (uri.scheme == "stripe-cancel") {
//       // Optional: show cancel message
//     }
//   });

//   // For cold start
//   final initialUri = await getInitialUri();
//   if (initialUri != null) {
//     if (initialUri.scheme == "stripe-success") {
//       final sessionId = initialUri.queryParameters['session_id'] ?? '';
//       if (sessionId.isNotEmpty) {
//         _verifyAndUpdateSubscription(sessionId);
//       }
//     }
//   }
// }




//   @override
//   Widget build(BuildContext context) {
//     if (userId == 0) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(color: AppColors.gold),
//         ),
//       );
//     }

//     return ChangeNotifierProvider(
//       create: (_) => SubscriptionViewModel(userId: userId),
//       child: Consumer<SubscriptionViewModel>(
//         builder: (context, vm, _) {
//           return Scaffold(
//             backgroundColor: AppColors.emerald,
//             appBar: AppBar(
//               title: const Text('Subscription'),
//               backgroundColor: AppColors.darkEmerald,
//             ),
//             body: (vm.loading || isVerifying)
//                 ? const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(color: AppColors.gold),
//                         SizedBox(height: 16),
//                         Text(
//                           "Confirming Subscription...",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : SubscriptionCard(
//   isPremium: vm.isPremium,
//   expiryDate: vm.expiryDate.isNotEmpty
//       ? 'Expires: ${vm.expiryDate}'
//       : 'No active subscription',
//   onSubscribe: () async {
//     final res = await SubscriptionApi.createCheckoutSession(userId);
//     final url = res['url'];
//     if (url != null) {
//       await launchUrl(Uri.parse(url),
//           mode: LaunchMode.externalApplication);
//     }
//   },
// )
// ,
//             bottomNavigationBar: const HomeBottomBar(currentIndex: 0),
//           );
//         },
//       ),
//     );
//   }
// }

part of '../subscription.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int userId = 0;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id') ?? 0;

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (userId == 0) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.gold),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => SubscriptionViewModel(userId: userId),
      child: Consumer<SubscriptionViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.emerald,
            appBar: AppBar(
              title: const Text('Subscription'),
              backgroundColor: AppColors.darkEmerald,
            ),
            body: vm.loading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.gold),
                        SizedBox(height: 16),
                        Text(
                          "Loading Subscription...",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : SubscriptionCard(
                    isPremium: vm.isPremium,
                    expiryDate: vm.expiryDate.isNotEmpty
                        ? 'Expires: ${vm.expiryDate}'
                        : 'No active subscription',
                    onSubscribe: () async {
                      final res =
                          // await SubscriptionApi.createCheckoutSession(userId);
                          await SubscriptionApi.createCheckoutSession(userId,platform: kIsWeb ? "web" : "mobile",);

                      final url = res['url'];
                      if (url != null) {
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
            bottomNavigationBar: const HomeBottomBar(currentIndex: 0),
          );
        },
      ),
    );
  }
}
