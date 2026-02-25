import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qasas_divine_tales/features/auth/auth.dart';
import 'package:qasas_divine_tales/features/auth/viewmodel/auth_service.dart';
import 'package:qasas_divine_tales/features/bookmark/bookmark.dart';
import 'package:qasas_divine_tales/features/home/home.dart';
import 'package:qasas_divine_tales/features/quizes/quizes.dart';
import 'package:qasas_divine_tales/features/references/references.dart';
import 'package:qasas_divine_tales/features/setting/setting.dart';
import 'package:qasas_divine_tales/features/splash/splash.dart';
import 'package:qasas_divine_tales/features/stories/stories.dart';
import 'package:qasas_divine_tales/features/subscription/subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';





part 'api/api_client.dart';
part 'api/bookmarks_api.dart';
part  'api/auth_api.dart';
part  'api/stories_api.dart';
part  'api/subscription_api.dart';
part  'routes/app_router.dart';
part  'themes/app_theme.dart';
part  'themes/app_colors.dart';
part 'api/quiz_api.dart';

