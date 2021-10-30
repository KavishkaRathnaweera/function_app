import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Components/TextWrite.dart';
import 'package:function_app/Views/loginScreen.dart';
import 'package:function_app/main.dart';
import 'package:integration_test/integration_test.dart';

import 'package:function_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Integration test with User Role', () {
    testWidgets("Load  Login screen ", (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pump(Duration(seconds: 5));
      await tester.enterText(find.byKey(Key('textFieldEmail')), 'postman');
      await tester.enterText(find.byKey(Key('textFieldPassword')), '1234');
      await tester.pump();
      expect(find.text('postman'), findsOneWidget);
      expect(find.text('1234'), findsOneWidget);
    });
    testWidgets("Navigate to postman Screen when enter email of 'Postman' user",
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pump(Duration(seconds: 5));
      await tester.enterText(
          find.byKey(Key('textFieldEmail')), 'postman@gmail.com');
      await tester.enterText(find.byKey(Key('textFieldPassword')), '123456');
      await tester.tap(find.byType(ReusableButton));
      await tester.pump(Duration(seconds: 12));
      await tester.pumpAndSettle();
      expect(find.text('Postman'), findsWidgets);
    });
    testWidgets(
        "Navigate to Delivery log keeper Screen "
        "when enter email of 'Delivery log keeper' user",
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pump(Duration(seconds: 5));
      await tester.enterText(
          find.byKey(Key('textFieldEmail')), 'deliver@gmail.com');
      await tester.enterText(find.byKey(Key('textFieldPassword')), '123456');
      await tester.tap(find.byType(ReusableButton));
      await tester.pump(Duration(seconds: 12));
      await tester.pumpAndSettle();
      expect(find.text('Delivery Log Keeper'), findsWidgets);
    });
    testWidgets(
        "Other than Postman or Delivery log keeper cannot access Application",
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pump(Duration(seconds: 5));
      await tester.enterText(
          find.byKey(Key('textFieldEmail')), 'supervisor22@gmail.com');
      await tester.enterText(find.byKey(Key('textFieldPassword')), '111111');
      await tester.tap(find.byType(ReusableButton));
      await tester.pump(Duration(seconds: 5));
      await tester.pumpAndSettle();
      expect(find.text('Permission Denied for this user'), findsWidgets);
    });
  });
}

/*
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/foo_test.dart
 */
