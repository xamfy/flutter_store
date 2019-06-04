// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_store/main.dart';
import 'package:flutter_store/widgets/color_loader.dart';

void main() {
  testWidgets('CircularLoader and AppBar title test',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MyApp());
      expect(find.text("Stores List"), findsOneWidget);
      expect(find.byType(ColorLoader), findsOneWidget);
      // await tester.pump(Duration(seconds: 10));
    });
  });
}
