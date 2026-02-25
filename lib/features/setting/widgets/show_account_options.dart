part of '../setting.dart';

void showAccountOptions(AuthViewmodel viewModel, BuildContext parentContext) {
  showModalBottomSheet(
    context: parentContext,
    backgroundColor: AppColors.emerald,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (sheetContext) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.gold),
              title: const Text("Logout"),
              onTap: () async {
                Navigator.of(sheetContext).pop(); // close sheet
                final success = await viewModel.logout();

                // ✅ use parentContext here
                if (parentContext.mounted) {
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    SnackBar(
                      content: Text(viewModel.message ?? "Action completed"),
                      backgroundColor: success ? Colors.green : AppColors.error,
                    ),
                  );

                  if (success) {
                    parentContext.go('/login'); // go_router navigation
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: AppColors.error),
              title: const Text("Delete Account", style: TextStyle(color: AppColors.white)),
              onTap: () async {
                Navigator.of(sheetContext).pop();
                final success = await viewModel.deleteAccount();

                if (parentContext.mounted) {
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    SnackBar(
                      content: Text(viewModel.message ?? "Action completed"),
                      backgroundColor: success ? Colors.green : AppColors.error,
                    ),
                  );

                  if (success) {
                    parentContext.go('/login');
                  }
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
