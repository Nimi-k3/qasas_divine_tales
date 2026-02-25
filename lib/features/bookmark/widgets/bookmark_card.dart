part of '../bookmark.dart';

class BookmarkCard extends StatelessWidget {
  final Map<String, dynamic> bookmark;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const BookmarkCard({
    super.key,
    required this.bookmark,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.emerald,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(bookmark['title_en'] ?? ''),
        subtitle: Text(
          'Chapter ${bookmark['chapter_order']} • ${bookmark['story_type']}',
          style: const TextStyle(color: AppColors.gold),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: AppColors.gold),
          onPressed: onRemove,
        ),
        onTap: onTap,
      ),
    );
  }
}
