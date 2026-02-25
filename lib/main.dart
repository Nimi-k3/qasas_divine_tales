import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:qasas_divine_tales/app.dart';    
import 'package:qasas_divine_tales/features/auth/viewmodel/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // ✅ preload login state
  final userId = prefs.getInt('user_id');
  AuthService.setLoggedIn(userId != null);

  // ✅ preload first run flag
  final firstRunDone = prefs.getBool('first_run_done') ?? false;
  AuthService.setFirstRun(!firstRunDone);

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const QasasApp(),
    ),
  );
}
