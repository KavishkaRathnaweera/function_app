import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Components/TextWrite.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/Views/SignatureView.dart';
import 'package:function_app/Views/loginScreen.dart';
import 'package:function_app/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integration_test/integration_test.dart';

import 'package:function_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Delivered post screen integration test', () {
    group('Render screen according to post type', () {
      testWidgets("Render Normal Delivered post screen",
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
        await tester.tap(find.byKey(Key('normalPost')));
        await tester.pump(Duration(seconds: 1));
        await tester.tap(find.byKey(Key('nDelivered')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Normal Delivered Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
      testWidgets("Render Registered Delivered post screen",
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
        await tester.tap(find.byKey(Key('registeredPost')));
        await tester.pump(Duration(seconds: 1));
        await tester.tap(find.byKey(Key('rDelivered')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Registered Delivered Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
      testWidgets("Render Package Delivered post screen",
          (WidgetTester tester) async {
        final scaffoldKey = 'postmanScafKey';
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
        await tester.tap(find.byKey(Key('packagePost')));
        await tester.pump(Duration(seconds: 1));
        await tester.tap(find.byKey(Key('pDelivered')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Package Delivered Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
    });
    group('Render functions on Delivered screen', () {
      testWidgets("Render Normal Delivered post screen functions",
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
        await tester.tap(find.byKey(Key('normalPost')));
        await tester.pump(Duration(seconds: 1));
        await tester.tap(find.byKey(Key('nDelivered')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Normal Delivered Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
      testWidgets("Render Registered Delivered post screen functions",
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
        await tester.tap(find.byKey(Key('registeredPost')));
        await tester.pump(Duration(seconds: 1));
        await tester.tap(find.byKey(Key('rDelivered')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Registered Delivered Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
      testWidgets("Render Package Delivered post screen functions",
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
        await tester.tap(find.byKey(Key('packagePost')));
        await tester.pump(Duration(seconds: 1));
        await tester.tap(find.byKey(Key('pDelivered')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Package Delivered Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
    });
  });
}

/*
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/foo_test.dart
 */
