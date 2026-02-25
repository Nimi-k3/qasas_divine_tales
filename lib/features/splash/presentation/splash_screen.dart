part of '../splash.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  late OnboardingViewModel _viewModel;

@override
void initState() {
  super.initState();
  _viewModel = context.read<OnboardingViewModel>();
  _viewModel.addListener(() => setState(() {}));
}


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F3D3E), Colors.black],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _viewModel.controller,
                onPageChanged: _viewModel.updateIndex,
                itemCount: _viewModel.splashData.length,
                itemBuilder: (context, index) {
                  final item = _viewModel.splashData[index];
                  return OnboardingContent(
                    image: item["image"]!,
                    title: item["title"]!,
                    desc: item["desc"]!,
                  );
                },
              ),
            ),
            PageIndicator(
              count: _viewModel.splashData.length,
              currentIndex: _viewModel.currentIndex,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  if (_viewModel.isLastPage) {
                    await _viewModel.completeOnboarding(); // ✅ persist flag
                    if (mounted) context.go('/login');     // ✅ navigate
                  } else {
                    _viewModel.handleNext(() {});
                  }
                },
                child: Text(
                  _viewModel.isLastPage ? "Get Started" : "Next",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
