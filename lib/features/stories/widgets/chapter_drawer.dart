// part of '../stories.dart';

// class ChapterDrawer extends StatelessWidget {
//   final List chapters;
//   final List audio;
//   final bool isPremium;
//   final int storyId;
//   final String storyType;
//   final String prophetName;
//   final String lang;

//   const ChapterDrawer({
//     super.key,
//     required this.chapters,
//     required this.audio,
//     required this.isPremium,
//     required this.storyId,
//     required this.storyType,
//     required this.prophetName,
//     required this.lang,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.75,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(24),
//             bottomLeft: Radius.circular(24),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               spreadRadius: 2,
//             )
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: AppColors.emerald,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(24),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'assets/splash/qasas_logo.png',
//                     height: 100,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     prophetName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.all(12),
//                 itemCount: chapters.length,
//                 separatorBuilder: (_, __) => const Divider(),
//                 itemBuilder: (_, i) {
//                   final ch = chapters[i];
//                   final title = lang == 'en' ? ch['title_en'] : ch['title_ur'];
//                   return ListTile(
//                     textColor: AppColors.emerald,
//                     title: Text(title ?? ''),
//                     leading: Icon(Icons.book, color: AppColors.gold),
//                     onTap: () {
//                       Navigator.pop(context);
//                       Navigator.pushNamed(
//                         context,
//                         '/story_detail',
//                         arguments: {
//                           'chapter': ch,
//                           'chapters': chapters,
//                           'storyId': storyId,
//                           'audio': audio,
//                           'isPremium': isPremium,
//                           'references': ch['references'] ?? [],
//                           'storyType': storyType,
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
part of '../stories.dart';

class ChapterDrawer extends StatelessWidget {
  final List chapters;
  final List audio;
  final bool isPremium;
  final int storyId;
  final String storyType;
  final String prophetName;
  final String lang;

  const ChapterDrawer({
    super.key,
    required this.chapters,
    required this.audio,
    required this.isPremium,
    required this.storyId,
    required this.storyType,
    required this.prophetName,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.emerald,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/splash/qasas_logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    prophetName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: chapters.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, i) {
                  final ch = chapters[i];
                  final title = lang == 'en' ? ch['title_en'] : ch['title_ur'];
                  return ListTile(
                    textColor: AppColors.emerald,
                    title: Text(title ?? ''),
                    leading: Icon(Icons.book, color: AppColors.gold),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/story_detail',
                        arguments: {
                          'chapter': ch,
                          'chapters': chapters,
                          'storyId': storyId,
                          'audio': audio,
                          'isPremium': isPremium,
                          'references': ch['references'] ?? [],
                          'storyType': storyType,
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
