// part of '../auth.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     return Consumer<AuthViewmodel>(
//         builder: (context, viewModel, _) {
//           // Handle messages (snackbar + navigation)
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (viewModel.message != null) {
//               showAuthSnackBar(
//                 context,
//                 viewModel.message!,
//                 error: viewModel.message!.toLowerCase().contains("fail") ||
//                        viewModel.message!.toLowerCase().contains("error"),
//               );

//               if (viewModel.message == "Login successful") {
//                 context.go('/home');
//               }

//               viewModel.clearMessage();
//             }
//           });

//           return Scaffold(
//             backgroundColor: AppColors.emerald,
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 80),
//                     Image.asset('assets/splash/qasas_logo.png', width: 150),
//                     const SizedBox(height: 40),
//                     const Text(
//                       "Welcome Back",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.gold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       "Login to continue exploring stories",
//                       style: TextStyle(
//                         color: AppColors.textSecondary,
//                         fontSize: 16,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 30),

//                     // Email
//                     AuthTextField(
//                       controller: emailController,
//                       hintText: "Email",
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 16),

//                     // Password
//                     AuthTextField(
//                       controller: passwordController,
//                       hintText: "Password",
//                       isPassword: true,
//                     ),
//                     const SizedBox(height: 24),

//                     // Login Button
//                     viewModel.isLoading
//                         ? const CircularProgressIndicator(color: AppColors.gold)
//                         : AuthButton(
//                             text: "Login",
//                             onPressed: () => viewModel.login(
//                               emailController.text,
//                               passwordController.text,
//                             ),
                            
//                           ),

//                     const SizedBox(height: 20),

//                     // Register link
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Don't have an account? ",
//                           style: TextStyle(color: AppColors.textSecondary),
//                         ),
//                         GestureDetector(
//                           onTap: () => context.go('/register'),
//                           child: const Text(
//                             "Register",
//                             style: TextStyle(
//                               color: AppColors.gold,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
      
//     );
//   }
// }
part of '../auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final viewModel = context.watch<AuthViewmodel>();

    // Handle messages (snackbar + navigation)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.message != null) {
        showAuthSnackBar(
          context,
          viewModel.message!,
          error: viewModel.message!.toLowerCase().contains("error") ||
                 viewModel.message!.toLowerCase().contains("fail"),
        );

        if (viewModel.message == "Login successful") {
          context.go('/home');
        }

        viewModel.clearMessage();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.emerald,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/splash/qasas_logo.png', width: 150),
              const SizedBox(height: 40),

              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),

              const SizedBox(height: 12),
              const Text(
                "Login to continue exploring stories",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              AuthTextField(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              AuthTextField(
                controller: passwordController,
                hintText: "Password",
                isPassword: true,
              ),

              const SizedBox(height: 24),

              viewModel.isLoading
                  ? const CircularProgressIndicator(color: AppColors.gold)
                  : AuthButton(
                      text: "Login",
                      onPressed: () {
                        viewModel.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                    ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/register'),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
