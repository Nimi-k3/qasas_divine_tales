part of '../subscription.dart';

class SubscriptionCard extends StatelessWidget {
  final bool isPremium;
  final String expiryDate;
  final VoidCallback onSubscribe;

  const SubscriptionCard({
    super.key,
    required this.isPremium,
    required this.expiryDate,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.gold, width: 3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkEmerald.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isPremium)
            Column(
              children: [
                const Icon(Icons.workspace_premium,
                    size: 90, color: AppColors.gold),
                const SizedBox(height: 20),
                Text(
                  'You are a Premium User!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkEmerald,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Expiry Date: $expiryDate',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.emerald,
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                const Icon(Icons.lock, size: 90, color: Colors.grey),
                const SizedBox(height: 20),
                Text(
                  'Unlock Premium Content',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkEmerald,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onSubscribe,
                  child: const Text(
                    'Subscribe Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
