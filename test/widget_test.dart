import 'package:flutter/foundation.dart' show Key;
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Test for rendered UI', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder starCardFinder = find.byKey(Key('avgStar'));

    expect(starCardFinder, findsOneWidget);
  }, skip: true);
}
