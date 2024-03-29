import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx_review/review_page.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:mobx_review/service_locator.dart';

Future<void> main() async {
  /// https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.fuchsia;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }

  WidgetsFlutterBinding.ensureInitialized();
  await registerReleaseDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Review App',
      theme: ThemeData.light(),
      home: ReviewPage(),
    );
  }
}
