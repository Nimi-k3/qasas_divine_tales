part of '../quizes.dart';

// class ProphetsQuizzesScreen extends StatelessWidget {
//   final int userId;
//   const ProphetsQuizzesScreen({super.key, required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ProphetsQuizzesViewModel()..loadProphets(),
//       child: Consumer<ProphetsQuizzesViewModel>(
//         builder: (context, vm, _) {
//           return Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               title: const Text("Prophets Quizzes"),
//               backgroundColor: AppColors.darkEmerald,
//               elevation: 0,
//             ),
//             body: vm.loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView.separated(
//                     padding: const EdgeInsets.all(12),
//                     itemCount: vm.prophets.length,
//                     separatorBuilder: (_, __) => const Divider(),
//                     itemBuilder: (context, index) {
//                       final prophet = vm.prophets[index];
//                       return ProphetQuizTile(prophet: prophet);
//                     },
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }

class ProphetsQuizzesScreen extends StatelessWidget {
  final int userId;
  const ProphetsQuizzesScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProphetsQuizzesViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Prophets Quizzes"),
        backgroundColor: AppColors.darkEmerald,
        elevation: 0,
      ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: vm.prophets.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final prophet = vm.prophets[index];
                return ProphetQuizTile(prophet: prophet);
              },
            ),
      bottomNavigationBar: const HomeBottomBar(currentIndex: 0),
    );
  }
}
