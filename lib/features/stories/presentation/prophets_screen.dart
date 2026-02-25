// part of '../stories.dart';

// class ProphetsScreen extends StatelessWidget {
//   const ProphetsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F7F4),
//       appBar: const HomeAppbar(),

//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: FutureBuilder<List>(
//           future: StoriesApi.getProphets(),
//           builder: (context, snapshot) {
//             /// ---------- LOADING ----------
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(color: AppColors.emerald),
//               );
//             }

//             /// ---------- ERROR ----------
//             if (snapshot.hasError) {
//               return const Center(
//                 child: Text(
//                   'Failed to load prophets',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               );
//             }

//             final prophets = snapshot.data ?? [];

//             /// ---------- EMPTY ----------
//             if (prophets.isEmpty) {
//               return _emptyState();
//             }

//             /// ---------- LIST ----------
//             return ListView.separated(
//               itemCount: prophets.length,
//               separatorBuilder: (_, __) => const SizedBox(height: 10),
//               itemBuilder: (context, index) {
//                 final prophet = prophets[index];
//                 return _prophetTile(
//                   context: context,
//                   prophet: prophet,
//                 );
//               },
//             );
//           },
//         ),
//       ),

//       /// ---------- BOTTOM NAV ----------
//       bottomNavigationBar: HomeBottomBar(currentIndex: 0,),
//     );
//   }

 

  
// }

part of '../stories.dart';

class ProphetsScreen extends StatelessWidget {
  const ProphetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the global AuthViewmodel to get the userId
    final auth = context.watch<AuthViewmodel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4),
      appBar: const HomeAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List>(
          future: StoriesApi.getProphets(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.emerald),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Failed to load prophets',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            final prophets = snapshot.data ?? [];

            if (prophets.isEmpty) {
              return const Center(child: Text("No prophets found"));
            }

            return ListView.separated(
              itemCount: prophets.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final prophet = prophets[index];
                return _prophetTile(
                  context: context,
                  prophet: prophet,
                  // Pass the userId from our global Auth provider
                  userId: auth.userId, 
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const HomeBottomBar(currentIndex: 0),
    );
  }

}