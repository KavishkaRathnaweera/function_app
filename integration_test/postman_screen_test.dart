import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Components/TextWrite.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/Views/loginScreen.dart';
import 'package:function_app/main.dart';
import 'package:integration_test/integration_test.dart';

import 'package:function_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Render Postman screen ", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump(Duration(seconds: 5));
    await tester.enterText(
        find.byKey(Key('textFieldEmail')), 'postman@gmail.com');
    await tester.enterText(find.byKey(Key('textFieldPassword')), '123456');
    await tester.tap(find.byType(ReusableButton));
    await tester.pump(Duration(seconds: 12));
    await tester.pumpAndSettle();
    expect(find.text('Normal Post Details'), findsOneWidget);
    expect(find.text('Registered Post Details'), findsOneWidget);
    expect(find.text('Package Post Details'), findsOneWidget);
    expect(find.text('Remaining'), findsNWidgets(3));
    expect(find.text('Delivered'), findsNWidgets(3));
    expect(find.text('Rejected'), findsNWidgets(3));
  });
}

/*
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/foo_test.dart
 */
