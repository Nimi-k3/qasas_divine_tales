 part of '../stories.dart';
 

 /// ---------- PROPHET TILE ----------
  Widget _prophetTile({
    required BuildContext context,
    required Map prophet,
    required int userId,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.push(
          '/stories',
          extra: {'prophet': prophet, 'userId': userId},
        );
      
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppColors.emerald.withOpacity(0.95),
              AppColors.darkEmerald,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.auto_stories,
              color: AppColors.gold,
              size: 28,
            ),
            const SizedBox(width: 14),

            /// Names
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prophet['name_en'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    prophet['name_ur'],
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontSize: 13,
                      fontFamily: 'NotoNastaliq',
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.gold,
            ),
          ],
        ),
      ),
    );
  }


  /// ---------- EMPTY STATE ----------
  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No prophets added yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Please check back later',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }