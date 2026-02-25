part of '../home.dart';

class HomeBottomBar extends StatelessWidget {
  final int currentIndex;

  const HomeBottomBar({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.emerald,
      currentIndex: currentIndex,
      selectedItemColor: AppColors.gold,
      unselectedItemColor: Colors.white70,
      onTap: (index) {
        if (index == 0) context.go('/home');
        if (index == 1) context.go('/bookmarks');
        if (index == 2) context.go('/settings');
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }


  
}
