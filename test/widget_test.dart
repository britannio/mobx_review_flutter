import 'package:flutter/foundation.dart' show Key;
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx_review/service_locator.dart';

import '../lib/main.dart';

Future<void> main() async {
  await registerMockDependencies();
  testWidgets('Test for rendered UI', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder starCardFinder = find.byKey(Key('avgStar'));

    expect(starCardFinder, findsOneWidget);
  });
}
