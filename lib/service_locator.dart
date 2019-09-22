import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mobx_review/services/hive_review_service.dart';
import 'package:mobx_review/services/mock_review_service.dart';
import 'package:mobx_review/services/review_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

final GetIt sl = GetIt.instance;

Future<void> registerReleaseDependencies() async {
  final Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  final Box reviewBox = await Hive.openBox('review');

  sl.registerSingleton<ReviewService>(HiveReviewService(reviewBox));
}

Future<void> registerMockDependencies() async {
  sl.registerSingleton<ReviewService>(MockReviewService());
}
