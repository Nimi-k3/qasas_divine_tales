part of '../stories.dart';

class StoryTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool locked;
  final VoidCallback? onTap;

  const StoryTypeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.locked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Icon(
                locked ? Icons.lock : Icons.arrow_forward_ios,
                color: locked ? Colors.red : null,
                size: locked ? 22 : 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
