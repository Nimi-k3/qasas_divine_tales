part of '../stories.dart';

class StoriesScreen extends StatelessWidget {
  final Map prophet;
  final int userId;

  const StoriesScreen({
    super.key,
    required this.prophet,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoriesViewModel(
        storyId: prophet['id'],
        userId: userId,
      ),
      child: Consumer<StoriesViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(prophet['name_en'] ?? 'Story'),
            ),
            body: vm.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      StoryTypeCard(
                        title: 'Short Story',
                        subtitle: 'Brief overview of life',
                        icon: Icons.menu_book,
                        locked: false,
                        onTap: vm.shortChapters.isEmpty
                            ? null
                            : () {
                                context.push(
                                  '/story_detail',
                                  extra: {
                                    'chapter': vm.shortChapters.first,
                                    'chapters': vm.shortChapters,
                                    'storyId': vm.storyId,
                                    'audio': [],
                                    'isPremium': false,
                                    'references': vm.shortChapters.first['references'] ?? [],
                                    'storyType': 'short',
                                  },
                                );
                              },
                      ),
                      const SizedBox(height: 16),
                      StoryTypeCard(
                        title: 'Life Journey',
                        subtitle: 'Complete detailed story',
                        icon: Icons.auto_stories,
                        locked: !vm.isPremium || vm.longChapters.isEmpty,
                        onTap: () {
                          if (!vm.isPremium || vm.longChapters.isEmpty) return;
                          context.push(
                            '/story_detail',
                            extra: {
                              'chapter': vm.longChapters.first,
                              'chapters': vm.longChapters,
                              'storyId': vm.storyId,
                              'audio': vm.audio,
                              'isPremium': true,
                              'references': vm.longChapters.first['references'] ?? [],
                              'storyType': 'long',
                            },
                          );
                        },
                      ),
                    ],
                  ),

          bottomNavigationBar: const HomeBottomBar(currentIndex: 0),
          );
        },
      ),
    );
  }
}
