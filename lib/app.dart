import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:qasas_divine_tales/core/core.dart';
import 'package:qasas_divine_tales/features/auth/auth.dart';
import 'package:qasas_divine_tales/features/bookmark/bookmark.dart';
import 'package:qasas_divine_tales/features/home/home.dart';
import 'package:qasas_divine_tales/features/quizes/quizes.dart';
import 'package:qasas_divine_tales/features/references/references.dart';
import 'package:qasas_divine_tales/features/splash/splash.dart';
import 'package:qasas_divine_tales/features/subscription/subscription.dart';
import 'package:provider/provider.dart';

class QasasApp extends StatelessWidget {
  const QasasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewmodel()),
        ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (_) => LogoViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        // ✅ ProxyProvider depends on AuthViewmodel
        // Every time AuthViewmodel changes (login/logout), this rebuilds
        ChangeNotifierProxyProvider<AuthViewmodel, SubscriptionViewModel>(
          create: (context) => SubscriptionViewModel(userId: 0), // Start with 0
          update: (context, auth, previousSub) => 
          SubscriptionViewModel(userId: auth.userId), // Update with real ID
        ),
        
        // ChangeNotifierProvider(create: (_) => StoriesViewModel(storyId: 0, userId: 0)),
        // ChangeNotifierProvider(create: (_) => StoryDetailViewModel(chapter:{}, storyId: 0, audio: [], references: [], chapters: [], storyType: '')),
        
        ChangeNotifierProvider(create: (_) => ReferencesViewModel()),
        ChangeNotifierProxyProvider<AuthViewmodel, BookmarksViewModel>(
          create: (context) => BookmarksViewModel(userId: 0), // Start with 0
          update: (context, auth, previousSub) => 
          BookmarksViewModel(userId: auth.userId), // Update with real ID
        ),
        ChangeNotifierProvider(create: (_) => ProphetsQuizzesViewModel()..loadProphets()),
        ChangeNotifierProvider(create: (_) => QuizViewModel())
    
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        builder: DevicePreview.appBuilder,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

