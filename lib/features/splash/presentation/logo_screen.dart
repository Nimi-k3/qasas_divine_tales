// part of '../splash.dart';

// class LogoScreen extends StatefulWidget {
//   const LogoScreen({super.key});

//   @override
//   State<LogoScreen> createState() => _LogoScreenState();
// }

// class _LogoScreenState extends State<LogoScreen> {
//   final _viewModel = LogoViewModel();

//   @override
//   void initState() {
//     super.initState();
//     _viewModel.getNextRoute().then((route) {
//       if (mounted) context.go(route);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image(
//           image: AssetImage('assets/splash/qasas_logo.png'),
//           width: 240,
//           height: 240,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }

part of '../splash.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final viewModel = context.read<LogoViewModel>(); // ✅ works now
      final route = await viewModel.getNextRoute();
      if (mounted) context.go(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/splash/qasas_logo.png'),
          width: 240,
          height: 240,
        ),
      ),
    );
  }
}
