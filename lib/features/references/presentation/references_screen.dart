// part of '../references.dart';

// class ReferencesScreen extends StatelessWidget {
//   const ReferencesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) {
//         final vm = ReferencesViewModel();
//         vm.loadReferences();
//         return vm;
//       },
//       child: Consumer<ReferencesViewModel>(
//         builder: (context, vm, _) {
//           return Scaffold(
//             backgroundColor: AppColors.emerald,
//             appBar: AppBar(
//               title: const Text('References'),
//               actions: [
//                 IconButton(
//                   icon: const Icon(Icons.language),
//                   onPressed: vm.toggleLanguage,
//                 ),
//               ],
//             ),
//             body: vm.loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Container(
//                       width: double.infinity,
//                       height: double.infinity,
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           color: AppColors.gold,
//                           width: 4,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.darkEmerald.withOpacity(0.3),
//                             blurRadius: 8,
//                             offset: const Offset(4, 4),
//                           ),
//                         ],
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Scrollbar(
//                         child: ListView.builder(
//                           itemCount: vm.references.length,
//                           itemBuilder: (_, i) {
//                             final ref = vm.references[i];
//                             final text = vm.getReferenceText(ref);

//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 8.0),
//                               child: Center(
//                                 child: Text(
//                                   text,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: AppColors.emerald,
//                                     fontSize: 16,
//                                     height: 1.6,
//                                     fontFamily: vm.lang == 'ur'
//                                         ? 'NotoNastaliq'
//                                         : null,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
part of '../references.dart';

class ReferencesScreen extends StatefulWidget {
  const ReferencesScreen({super.key});

  @override
  State<ReferencesScreen> createState() => _ReferencesScreenState();
}

class _ReferencesScreenState extends State<ReferencesScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Use microtask or addPostFrameCallback to trigger the load 
    // after the first build using the global provider instance.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReferencesViewModel>().loadReferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Use Consumer to listen to the ViewModel already provided in main.dart
    return Consumer<ReferencesViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: AppColors.emerald,
          appBar: AppBar(
            backgroundColor: AppColors.emerald, // Consistent with theme
            elevation: 0,
            title: const Text('References'),
            actions: [
              IconButton(
                icon: const Icon(Icons.language),
                onPressed: vm.toggleLanguage,
              ),
            ],
          ),
          body: vm.loading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.gold),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.gold,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkEmerald.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: vm.references.length,
                        itemBuilder: (_, i) {
                          final ref = vm.references[i];
                          final text = vm.getReferenceText(ref);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.emerald,
                                  fontSize: 16,
                                  height: 1.6,
                                  fontFamily: vm.lang == 'ur'
                                      ? 'NotoNastaliq'
                                      : null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: const HomeBottomBar(currentIndex: 0),
        );
      },
    );
  }
}