part of '../bookmark.dart';


class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  int userId = 0;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id') ?? 0;
    setState(() {}); // rebuild to provide ViewModel
  }

  @override
  Widget build(BuildContext context) {
    if (userId == 0) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => BookmarksViewModel(userId: userId),
      child: Consumer<BookmarksViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Bookmarks'),
              backgroundColor: AppColors.emerald,
            ),
            body: vm.loading
                ? const Center(child: CircularProgressIndicator())
                : vm.bookmarks.isEmpty
                    ? const Center(
                        child: Text(
                          'No bookmarks yet',
                          style: TextStyle(color: AppColors.darkEmerald),
                        ),
                      )
                    : ListView.builder(
                        itemCount: vm.bookmarks.length,
                        itemBuilder: (context, index) {
                          final b = vm.bookmarks[index];
                          return BookmarkCard(
                            bookmark: b,
                            onTap: () async {
                              final extra = await vm.openChapter(b);
                              context.push('/story_detail', extra: extra);
                            },
                            onRemove: () => vm.removeBookmark(b),
                          );
                        },
                      ),
            bottomNavigationBar: const HomeBottomBar(currentIndex: 1),
          );
        },
      ),
    );
  }
}
