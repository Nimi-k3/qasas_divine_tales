part of '../stories.dart';
class StoryDetailViewModel extends ChangeNotifier {
  final Map<String, dynamic> chapter;
  final int storyId;
  final List audio;
  bool isPremium = false;
  final List references;
  final List chapters;
  final String storyType;

  String lang = 'en';
  bool darkMode = false;
  double fontSize = 18;
  bool isBookmarked = false;
  int? userId;
  bool loading = true;

  StoryDetailViewModel({
    required this.chapter,
    required this.storyId,
    required this.audio,
    // required this.isPremium,
    required this.references,
    required this.chapters,
    required this.storyType,
  }) {
    _init();
  }

  int? get chapterId =>
      chapter['id'] ?? chapter['chapter_id'] ?? chapter['chapterId'];

  String get title =>
      lang == 'en' ? chapter['title_en'] ?? '' : chapter['title_ur'] ?? '';

  String get content =>
      lang == 'en' ? (chapter['content_en'] ?? '') : (chapter['content_ur'] ?? '');

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    isPremium = prefs.getBool('is_premium') ?? false;

    await _loadUserAndBookmark();
    await _loadChapterContent();
    
    loading = false;
    notifyListeners();
  }

  Future<void> _loadChapterContent() async {
    if (storyType == 'long' && chapterId != null) {
      final chapterData = await StoriesApi.getChapterById(
        chapterId!,
        'long',
        storyId: storyId,
      );
      chapter.addAll(chapterData);
      notifyListeners();
    }
  }

  Future<void> _loadUserAndBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
    if (userId == null || chapterId == null) return;

    final type = storyType.isEmpty ? (isPremium ? 'long' : 'short') : storyType;
    isBookmarked = await BookmarksApi.isBookmarked(userId!, storyId, chapterId!, type);
    notifyListeners();
  }

  Future<void> toggleBookmark(int scrollPosition) async {
    if (userId == null || chapterId == null || storyId <= 0) return;
    final type = storyType.isEmpty ? (isPremium ? 'long' : 'short') : storyType;

    if (isBookmarked) {
      await BookmarksApi.remove(userId!, storyId, chapterId!, type);
    } else {
      await BookmarksApi.addOrUpdate(
        userId: userId!,
        storyId: storyId,
        chapterId: chapterId!,
        storyType: type,
        scrollPosition: scrollPosition,
      );
    }
    isBookmarked = !isBookmarked;
    notifyListeners();
  }

  void setLanguage(String newLang) {
    lang = newLang;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    darkMode = value;
    notifyListeners();
  }

  void adjustFontSize(double newSize) {
    fontSize = newSize.clamp(12, 40);
    notifyListeners();
  }

  /// ✅ Offline save for Web
  Future<void> saveOfflineWeb() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              title.isEmpty ? 'Story' : title,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 16),
            pw.Text(
              content.isEmpty ? 'No content available' : content,
              style: pw.TextStyle(fontSize: 14, height: 1.5),
            ),
            pw.SizedBox(height: 24),
            if (references.isNotEmpty) ...[
              pw.Text('References',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              ...references.map((ref) {
                final text = lang == 'en'
                    ? ref['ref_en'] ?? ref['en'] ?? ref.toString()
                    : ref['ref_ur'] ?? ref['ur'] ?? ref.toString();
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Text('• $text', style: pw.TextStyle(fontSize: 12)),
                );
              }),
            ]
          ],
        ),
      ),
    );

    final bytes = await pdf.save();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "${title.replaceAll(' ', '_')}.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  /// ✅ Offline save for Mobile
  Future<void> saveOfflineMobile(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title.isEmpty ? 'Story' : title,
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                content.isEmpty ? 'No content available' : content,
                style: pw.TextStyle(fontSize: 14, height: 1.5),
              ),
              pw.SizedBox(height: 24),
              if (references.isNotEmpty) ...[
                pw.Text(
                  'References',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 8),
                ...references.map((ref) {
                  final text = lang == 'en'
                      ? ref['ref_en'] ?? ref['en'] ?? ref.toString()
                      : ref['ref_ur'] ?? ref['ur'] ?? ref.toString();
                  return pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text('• $text', style: pw.TextStyle(fontSize: 12)),
                  );
                }),
              ]
            ],
          );
        },
      ),
    );

    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/${title.replaceAll(' ', '_')}.pdf");
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved offline: ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save offline')),
      );
    }
  }
}
