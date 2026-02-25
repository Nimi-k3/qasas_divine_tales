part of '../core.dart';

class AppRouter {
  static GoRouter router = GoRouter(
  initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LogoScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/prophets',
        builder: (context, state) => const ProphetsScreen(),
      ),

      // 🔹 STORIES SCREEN
      GoRoute(
        path: '/stories',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};
          return StoriesScreen(
            prophet: data['prophet'] ?? {},
            userId: data['userId'] ?? 0,
          );
        },
      ),

      GoRoute(
        path: '/story_detail',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          if (extra == null) {
            return const Scaffold(
              body: Center(child: Text("No story data provided")),
            );
          }

          return StoryDetailScreen(
            storyId: extra['storyId'] ?? 0,
            chapter: extra['chapter'] ?? {},
            chapters: extra['chapters'] ?? [],
            audio: extra['audio'] ?? [],
            references: extra['references'] ?? [],
            storyType: extra['storyType'] ?? 'short',
          );
        },
      ),

      GoRoute(
        path: '/references',
        builder: (context, state) => const ReferencesScreen(),
      ),

      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingScreen(),
      ),
      
     
GoRoute(
  path: '/subscription',
  builder: (_, __) => const SubscriptionScreen(),
),

    GoRoute(
  path: '/subscription-success',
  builder: (context, state) {
    final sessionId = state.uri.queryParameters['session_id'];

    if (sessionId != null) {
      Future.microtask(() async {
        try {
          // 1️⃣ Update subscription in backend
          await SubscriptionApi.updateSubscription(sessionId);

          // 2️⃣ Logout user
          await context.read<AuthViewmodel>().logout();

          // 3️⃣ Navigate to login
          if (context.mounted) context.go('/login');
        } catch (e) {
          debugPrint("Subscription success handling failed: $e");
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Something went wrong. Try again.")),
            );
          }
        }
      });
    }

    // Loader while processing
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.gold),
      ),
    );
  },
),



GoRoute(
  path: '/subscription-cancel',
  builder: (context, state) {
    return const SubscriptionScreen();
  },
),
      GoRoute(
        path: '/bookmarks',
        builder: (context, state) => const BookmarksScreen(),
      ),

      // 🔹 PROPHETS QUIZZES SCREEN (shows slabs of all prophets)
      GoRoute(
        path: '/prophets_quizzes',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return ProphetsQuizzesScreen(
            userId: extra['userId'] ?? 0,
          );
        },
      ),

      // 🔹 QUIZZES LIST SCREEN (for selected prophet)
      GoRoute(
        path: '/quizzes',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return QuizzesScreen(
            prophetId: extra['prophetId'] ?? 0,
            prophetName: extra['prophetName'] ?? 'Quizzes',
          );
        },
      ),

      // 🔹 QUIZ RESULT SCREEN
      GoRoute(
        path: '/quiz_result',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return QuizResultSummaryScreen(
            userId: extra['userId'] ?? 0,
          );
        },
      ),
    ],
  );

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') != null;
  }
}
