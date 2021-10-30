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

  group('Remaining post screen integration test', () {
    group('Render screen according to post type', () {
      testWidgets("Render Normal Remaining post screen",
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
        await tester.tap(find.byKey(Key('nRemain')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Normal Pending Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
      testWidgets("Render Registered Remaining post screen",
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
        await tester.tap(find.byKey(Key('rRemain')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Registered Pending Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
      testWidgets("Render Package Remaining post screen",
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
        await tester.tap(find.byKey(Key('pRemain')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Package Pending Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });
    });
    group('Render functions on remaining screen', () {
      testWidgets("Render Normal post screen functions",
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
        await tester.tap(find.byKey(Key('nRemain')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Normal Pending Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
        await tester.tap(find.byKey(Key('0')));
        await tester.pump(Duration(seconds: 8));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('bottomSheetList')), findsOneWidget);
        expect(find.byKey(Key('deliveredTextButton')), findsOneWidget);
        expect(find.byKey(Key('failedTextButton')), findsOneWidget);
      });
      testWidgets("Render Registered post screen functions",
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
        await tester.tap(find.byKey(Key('rRemain')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Registered Pending Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
        await tester.tap(find.byKey(Key('0')));
        await tester.pump(Duration(seconds: 5));
        await tester.pumpAndSettle();
        await tester.fling(
            find.byType(SignatureScreen), Offset(100, 100), 500.0);
        await tester.pumpAndSettle(Duration(seconds: 1));
        await tester.tap(find.byKey(Key('acceptButton')));
        await tester.pump(Duration(seconds: 10));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('bottomSheetList')), findsOneWidget);
        expect(find.byKey(Key('deliveredTextButton')), findsOneWidget);
        expect(find.byKey(Key('failedTextButton')), findsOneWidget);
      });
      testWidgets("Render Package post screen functions",
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
        await tester.tap(find.byKey(Key('pRemain')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('Package Pending Post'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
        await tester.tap(find.byKey(Key('0')));
        await tester.pump(Duration(seconds: 5));
        await tester.pumpAndSettle();
        await tester.fling(
            find.byType(SignatureScreen), Offset(100, 100), 500.0);
        await tester.pumpAndSettle(Duration(seconds: 1));
        await tester.tap(find.byKey(Key('acceptButton')));
        await tester.pump(Duration(seconds: 10));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('bottomSheetList')), findsOneWidget);
        expect(find.byKey(Key('deliveredTextButton')), findsOneWidget);
        expect(find.byKey(Key('failedTextButton')), findsOneWidget);
      });
    });
  });
}

/*
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/foo_test.dart
 */
