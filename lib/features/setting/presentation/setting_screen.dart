part of '../setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    // Access the global instance instead of creating a new one
    final viewModel = context.watch<AuthViewmodel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4),
      appBar: AppBar(
        backgroundColor: AppColors.emerald,
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Image.asset('assets/splash/qasas_logo.png', height: 200),
          ),
          const SizedBox(height: 30),
          
          // Account Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.person, color: AppColors.gold),
              title: const Text("Account"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => showAccountOptions(viewModel, context),
            ),
          ),
          
          // About Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.info, color: AppColors.gold),
              title: const Text("About"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => showAboutDialog(context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HomeBottomBar(currentIndex: 2),
    );
  }
}