import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Components/TextWrite.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/Views/loginScreen.dart';
import 'package:function_app/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integration_test/integration_test.dart';

import 'package:function_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Drawer Screen Integration test', () {
    testWidgets(
        "Navigate to Normal Remaining post screen when trapping Normal remaining",
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

      //expect(find.byType(Drawer), findsWidgets);
    });
    testWidgets(
        "Navigate to Normal Delivered post screen when trapping Normal Delivered",
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
      await tester.tap(find.byKey(Key('normalPost')));
      await tester.pump(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('nDelivered')));
      await tester.pump(Duration(seconds: 1));
      expect(find.text('Normal Delivered Post'), findsOneWidget);

      //expect(find.byType(Drawer), findsWidgets);
    });
    testWidgets(
        "Navigate to Normal Undeliverable post screen when trapping Normal Undeliverable",
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
      await tester.tap(find.byKey(Key('normalPost')));
      await tester.pump(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('nUndeliverable')));
      await tester.pump(Duration(seconds: 1));
      expect(find.text('Normal Undeliverable Post'), findsOneWidget);

      //expect(find.byType(Drawer), findsWidgets);
    });
    testWidgets(
        "Navigate to Registered Remaining post screen when trapping Registered remaining",
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
      await tester.tap(find.byKey(Key('registeredPost')));
      await tester.pump(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('rRemain')));
      await tester.pump(Duration(seconds: 1));
      expect(find.text('Registered Pending Post'), findsOneWidget);

      //expect(find.byType(Drawer), findsWidgets);
    });
    testWidgets(
        "Navigate to Registered delivered post screen when trapping Registered Delivered",
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
      await tester.tap(find.byKey(Key('registeredPost')));
      await tester.pump(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('rDelivered')));
      await tester.pump(Duration(seconds: 1));
      expect(find.text('Registered Delivered Post'), findsOneWidget);

      //expect(find.byType(Drawer), findsWidgets);
    });
    testWidgets(
        "Navigate to Registered undeliverable post screen when trapping Registered Undeliverable",
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
      await tester.tap(find.byKey(Key('registeredPost')));
      await tester.pump(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('rUndeliverable')));
      await tester.pump(Duration(seconds: 1));
      expect(find.text('Registered Undeliverable Post'), findsOneWidget);

      //expect(find.byType(Drawer), findsWidgets);
    });
    testWidgets(
        "Navigate to Package Remaining post screen when trapping Package Remaining",
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
    });
    testWidgets(
        "Navigate to Package Delivered post screen when trapping Package Delivered",
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
    });
    testWidgets(
        "Navigate to Package Undeliverable post screen when trapping Package Undeliverable",
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
      await tester.tap(find.byKey(Key('pUndeliverable')));
      await tester.pump(Duration(seconds: 1));
      expect(find.text('Package Undeliverable Post'), findsOneWidget);
    });
    testWidgets("Navigate Address screen when trapping Address in drawer",
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
      await tester.tap(find.byKey(Key('address')));
      await tester.pump(Duration(seconds: 20));
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text('ADD ADDRESS'), findsOneWidget);
    });
  });
}

/*
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/foo_test.dart
 */
