part of '../stories.dart';

class ReferenceList extends StatelessWidget {
  final List references;
  final String lang;

  const ReferenceList({super.key, required this.references, required this.lang});

  @override
  Widget build(BuildContext context) {
    if (references.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Divider(),
        const Text(
          'References',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(height: 8),
        ...references.map((ref) {
          final text = lang == 'en'
              ? ref['ref_en'] ?? ref['en'] ?? ref.toString()
              : ref['ref_ur'] ?? ref['ur'] ?? ref.toString();
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('• $text',
                style: const TextStyle(fontSize: 14, color: Colors.black87)),
          );
        }),
      ],
    );
  }
}
