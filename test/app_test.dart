import 'package:fanwaave_flutter/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the disconnected first frame and three routes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const FanwaaveApp());

    expect(find.text('Audience signals'), findsOneWidget);
    expect(find.text('Audience service disconnected'), findsOneWidget);
    expect(find.text('No typed endpoint configured'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey<String>('nav-1')));
    await tester.pumpAndSettle();
    expect(find.text('Moment scoring'), findsOneWidget);
    expect(find.text('Launch conversation'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey<String>('nav-2')));
    await tester.pumpAndSettle();
    expect(find.text('Observable routing'), findsOneWidget);
    expect(find.text('Delivery remains off'), findsOneWidget);
  });

  testWidgets('keeps every destination overflow-free at 320 by 640',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FanwaaveApp());
    expect(tester.takeException(), isNull);

    for (int index = 0; index < 3; index += 1) {
      await tester.tap(find.byKey(ValueKey<String>('nav-$index')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });
}
