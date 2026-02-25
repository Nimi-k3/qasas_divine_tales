part of '../stories.dart';

class ReaderSettings extends StatelessWidget {
  final StoryDetailViewModel vm;

  const ReaderSettings({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Language', style: TextStyle(color: Colors.white)),
            trailing: DropdownButton<String>(
              iconEnabledColor: AppColors.gold,
              dropdownColor: AppColors.emerald,
              value: vm.lang,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ur', child: Text('Urdu')),
              ],
              onChanged: (v) => vm.setLanguage(v!),
            ),
          ),
          SwitchListTile(
            activeThumbColor: AppColors.darkEmerald,
            activeTrackColor: AppColors.gold,
            inactiveThumbColor: AppColors.gold,
            inactiveTrackColor: AppColors.darkEmerald,
            title: const Text('Dark Mode', style: TextStyle(color: Colors.white)),
            value: vm.darkMode,
            onChanged: vm.toggleDarkMode,
          ),
          ListTile(
            title: const Text('Text Size', style: TextStyle(color: Colors.white)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: AppColors.gold),
                  onPressed: () => vm.adjustFontSize(vm.fontSize - 1),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: AppColors.gold),
                  onPressed: () => vm.adjustFontSize(vm.fontSize + 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
