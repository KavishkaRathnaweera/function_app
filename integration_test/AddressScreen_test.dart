import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/main.dart';
import 'package:integration_test/integration_test.dart';

import 'package:function_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Address screen integration test', () {
    testWidgets("Render Normal Undeliverable post screen",
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pump(Duration(seconds: 5));
      await tester.enterText(
          find.byKey(Key('textFieldEmail')), 'postman@gmail.com');
      await tester.enterText(find.byKey(Key('textFieldPassword')), '123456');
      await tester.tap(find.byType(ReusableButton));
      await tester.pump(Duration(seconds: 12));
      await tester.pumpAndSettle();
      await tester.dragFrom(
          tester.getTopLeft(find.byType(PostmanScreen)), Offset(300, 0));
      await tester.pump(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('address')));
      await tester.pump(Duration(seconds: 4));
      expect(find.text('ADD ADDRESS'), findsOneWidget);
      expect(find.text('Address No'), findsOneWidget);
      expect(find.text('Street 1'), findsOneWidget);
      expect(find.text('Street 2'), findsOneWidget);
      expect(find.text('City'), findsOneWidget);
      expect(find.text('Coordinates'), findsOneWidget);

      await tester.enterText(find.byKey(Key('address_key')), '123/3/3');
      await tester.enterText(find.byKey(Key('street1')), 'street1');
      await tester.enterText(find.byKey(Key('street2')), 'street2');
      await tester.enterText(find.byKey(Key('city')), 'kadawatha');

      await tester.pump();

      expect(find.text('123/3/3'), findsOneWidget);
      expect(find.text('street1'), findsOneWidget);
      expect(find.text('street2'), findsOneWidget);
      expect(find.text('kadawatha'), findsOneWidget);
    });
  });
}

/*
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/foo_test.dart
 */
