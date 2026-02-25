import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qasas_divine_tales/core/core.dart';
import 'package:qasas_divine_tales/features/auth/auth.dart';
import 'package:qasas_divine_tales/features/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw; 
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';


part 'presentation/prophets_screen.dart';
part 'presentation/stories_screen.dart';
part 'presentation/story_detail_screen.dart';
part 'widgets/prophet_tile.dart';
part 'widgets/story_type_card.dart';
part 'widgets/audio_player_widget.dart';
part 'widgets/reference_list.dart';
part 'widgets/reader_setting.dart';
part 'widgets/chapter_drawer.dart';

part 'viewmodels/stories_viewmodel.dart';
part 'viewmodels/stories_detail_viewmodel.dart';
