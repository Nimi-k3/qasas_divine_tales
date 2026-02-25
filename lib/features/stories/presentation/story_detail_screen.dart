// after clean architecture
part of '../stories.dart';

class StoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> chapter;
  final int storyId;
  final List audio;
  // final bool isPremium;
  final List references;
  final List chapters;
  final String storyType;

  const StoryDetailScreen({
    super.key,
    required this.chapter,
    required this.storyId,
    required this.audio,
    // required this.isPremium,
    required this.references,
    required this.chapters,
    required this.storyType,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoryDetailViewModel(
        chapter: chapter,
        storyId: storyId,
        audio: audio,
        // isPremium: isPremium,
        references: references,
        chapters: chapters,
        storyType: storyType,
      ),
      child: Consumer<StoryDetailViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: vm.darkMode ? Colors.black : const Color(0xFFF9F7F4),
            appBar: AppBar(
              backgroundColor: AppColors.darkEmerald,
              title: Text(vm.title.isEmpty ? 'Story' : vm.title),
            ),
            body: vm.loading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsetsDirectional.all(12),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(16),
                        decoration: BoxDecoration(
                           color: vm.darkMode ? Colors.black87 : Colors.white,
                           borderRadius: BorderRadius.circular(12),
                           border: Border.all(color: AppColors.darkEmerald, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vm.title,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.emerald)),
                            const SizedBox(height: 16),
                            Text(vm.content,
                                style: TextStyle(
                                  fontSize: vm.fontSize,
                                  height: 1.8,
                                  color: vm.darkMode ? Colors.white : Colors.black,
                                  fontFamily: vm.lang == 'ur' ? 'NotoNastaliq' : null,
                                )),
                            ReferenceList(references: vm.references, lang: vm.lang),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  ),
            bottomSheet: Container(
              color: AppColors.darkEmerald,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => vm.toggleBookmark(0),
                    child: Row(
                      children: [
                        Icon(
                          vm.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: vm.isBookmarked ? Colors.amber : Colors.white,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          vm.isBookmarked ? 'Bookmarked' : 'Bookmark',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
  onTap: () async {
    if (!vm.isPremium) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.darkEmerald,
          content: Text('Offline download is only available for premium users',style: TextStyle(color: Colors.white),),
        ),
      );
      return;
    }
    if (kIsWeb) {
      await vm.saveOfflineWeb();
    } else {
      await vm.saveOfflineMobile(context);
    }
  },
  child: const Row(
    children: [
      Icon(Icons.download, color: Colors.white),
      SizedBox(width: 6),
    ],
  ),
),

                  IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: () => showModalBottomSheet(
                      backgroundColor: AppColors.emerald,
                      context: context,
                      builder: (_) => ReaderSettings(vm: vm),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu_book, color: Colors.white),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black54,
                      builder: (_) => ChapterDrawer(
                        chapters: vm.chapters,
                        audio: vm.audio,
                        isPremium: vm.isPremium,
                        storyId: vm.storyId,
                        storyType: vm.storyType,
                        prophetName: vm.chapter['prophet_name'] ?? 'Chapters',
                        lang: vm.lang,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
