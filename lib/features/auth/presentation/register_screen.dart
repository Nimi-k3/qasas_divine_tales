// part of '../auth.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     return Consumer<AuthViewmodel>(
//         builder: (context, viewModel, _) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (viewModel.message != null) {
//               showAuthSnackBar(context, viewModel.message!,
//                   error: viewModel.message!.toLowerCase().contains("error"));
//               if (!viewModel.message!.toLowerCase().contains("error")) {
//                 context.go('/login'); // navigate only on success
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
//                       "Create Account",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.gold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       "Sign up to unlock all stories and features",
//                       style: TextStyle(
//                           color: AppColors.textSecondary, fontSize: 16),
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

//                     // Register Button
//                     viewModel.isLoading
//                         ? const CircularProgressIndicator(color: AppColors.gold)
//                         : AuthButton(
//                             text: "Register",
//                             onPressed: () => viewModel.register(
//                               emailController.text,
//                               passwordController.text,
//                             ),
//                           ),

//                     const SizedBox(height: 20),

//                     // Login link
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Already have an account? ",
//                           style: TextStyle(color: AppColors.textSecondary),
//                         ),
//                         GestureDetector(
//                           onTap: () => context.go('/login'),
//                           child: const Text(
//                             "Login",
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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
          error: viewModel.message!.toLowerCase().contains("error"),
        );

        if (!viewModel.message!.toLowerCase().contains("error")) {
          context.go('/login');
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
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),

              const SizedBox(height: 12),
              const Text(
                "Sign up to unlock all stories and features",
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
                      text: "Register",
                      onPressed: () {
                        viewModel.register(
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
                    "Already have an account? ",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: const Text(
                      "Login",
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
