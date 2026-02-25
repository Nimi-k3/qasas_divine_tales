part of '../home.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return  Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: const Color(0xFFF9F7F4),
            appBar: const HomeAppbar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 100, 16, 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    homeCard(
                      icon: Icons.auto_stories,
                      title: 'Prophets',
                      onTap: () => context.push('/prophets'),
                    ),
                    homeCard(
                      icon: Icons.menu_book,
                      title: 'References',
                      onTap: () => context.push('/references'),
                    ),
                    homeCard(
                      icon: Icons.workspace_premium,
                      title: viewModel.isPremium ? 'Premium User' : 'Subscriptions',
                      onTap: () => context.push('/subscription'),
                    ),
                    // homeCard( 
                    //   icon: Icons.quiz_outlined,
                    //   title: 'Quizzes', 
                    //   onTap: () async {
                    //      final prefs = await SharedPreferences.getInstance();
                    //       final userId = prefs.getInt('user_id') ?? 0;
                    //        context.push('/prophets_quizzes',
                    //         extra: { 'userId': userId, }); }, 
                    // ),
                    homeCard( 
                      icon: Icons.quiz_outlined,
                      title: 'Quizzes', 
                      onTap: () async {
                        if (viewModel.isPremium) {
      // ✅ User is premium, allow navigation
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id') ?? 0;
      if (context.mounted) {
        context.push('/prophets_quizzes', extra: {'userId': userId});
      }
    } else {
      // ❌ Not premium, show the themed dialog
      _showSubscriptionDialog(context);
    }
  }, 
),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: HomeBottomBar(currentIndex: 0),
          );
        },
      
    );
  }

}
