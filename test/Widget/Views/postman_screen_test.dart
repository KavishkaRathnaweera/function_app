import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:function_app/PostmanScreen.dart';

import '../../Mocks.dart';

void main() {
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  group('Postman Screen Test', () {
    // testWidgets('Render postman title', (WidgetTester tester) async {
    //   await tester
    //       .pumpWidget(createWidgetForTesting(child: new PostmanScreen()));
    //   expect(find.text('Postman'), findsOneWidget);
    // });
    // testWidgets('Render Screen title', (WidgetTester tester) async {
    //   await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
    //   await tester.pump();
    //   expect(find.text('Sri Lanka Post'), findsOneWidget);
    // });
    //
    // testWidgets('Email and password must assign to variable',
    //         (WidgetTester tester) async {
    //       await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
    //       await tester.enterText(find.byKey(Key('textFieldEmail')), 'postman');
    //       await tester.enterText(find.byKey(Key('textFieldPassword')), '1234');
    //       // await tester.tap(find.byType(ReusableButton));
    //       expect(find.text('postman'), findsOneWidget);
    //       expect(find.text('1234'), findsOneWidget);
    //     });
    // testWidgets('Show error when Email is empty', (WidgetTester tester) async {
    //   await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
    //   await tester.enterText(find.byKey(Key('textFieldEmail')), '');
    //   await tester.tap(find.byType(ReusableButton));
    //   await tester.pump();
    //   expect(find.text('Please Enter email'), findsOneWidget);
    // });
    // testWidgets('Show error when password is empty',
    //         (WidgetTester tester) async {
    //       await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
    //       await tester.enterText(find.byKey(Key('textFieldEmail')), 'postman');
    //       await tester.enterText(find.byKey(Key('textFieldPassword')), '');
    //       await tester.tap(find.byType(ReusableButton));
    //       await tester.pump();
    //       expect(find.text('Please Enter password'), findsOneWidget);
    //     });
    // testWidgets('Show error when email is invalid',
    //         (WidgetTester tester) async {
    //       await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
    //       await tester.enterText(find.byKey(Key('textFieldEmail')), 'postman');
    //       await tester.enterText(find.byKey(Key('textFieldPassword')), '1111');
    //       await tester.tap(find.byType(ReusableButton));
    //       await tester.pump();
    //       expect(find.text('Email is invalid'), findsOneWidget);
    //     });
    // testWidgets('should return true when valid email and password',
    //         (WidgetTester tester) async {
    //       var wid = new LoginScreen();
    //       var st = wid.createState();
    //       var result = st.validateEmailPassword('postman@gmail.com', '11111');
    //       expect(result, true);
    //     });
    // testWidgets('should return false when invalid email and password',
    //         (WidgetTester tester) async {
    //       var wid = new LoginScreen();
    //       await tester.pumpWidget(createWidgetForTesting(child: wid));
    //       var st = tester.state<LoginScreenState>(find.byType(LoginScreen));
    //       var result = st.validateEmailPassword('postmanil.com', '11111');
    //       expect(result, false);
    //     });
    // testWidgets('Get user from the database', (WidgetTester tester) async {
    //   var wid = new LoginScreen();
    //   await tester.pumpWidget(createWidgetForTesting(child: wid));
    //   await tester.enterText(
    //       find.byKey(Key('textFieldEmail')), 'postm@gmail.com');
    //   await tester.enterText(find.byKey(Key('textFieldPassword')), '111');
    //   await tester.tap(find.byType(ReusableButton));
    //   await tester.pump();
    //   expect(find.text('Error!'), findsOneWidget);
    //expect(result, false);
    // });
  });
}
