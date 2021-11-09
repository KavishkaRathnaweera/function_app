import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:function_app/Components/Alerts.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Views/loginScreen.dart';
import 'package:mockito/mockito.dart';

import '../../Mocks.dart';

class MockFirabaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {}

class MockFirebaseResult extends Mock implements UserCredential {}

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

  group('Login Screen Test', () {
    testWidgets('Render postOffice logo', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
      expect(find.byKey(Key('heroWidget')), findsOneWidget);
    });
    testWidgets('Render Screen title', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
      await tester.pump();
      expect(find.text('Sri Lanka Post'), findsOneWidget);
    });

    testWidgets('Email and password must assign to variable',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
      await tester.enterText(find.byKey(Key('textFieldEmail')), 'postman');
      await tester.enterText(find.byKey(Key('textFieldPassword')), '1234');
      // await tester.tap(find.byType(ReusableButton));
      expect(find.text('postman'), findsOneWidget);
      expect(find.text('1234'), findsOneWidget);
    });
    testWidgets('Show error when Email is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
      await tester.enterText(find.byKey(Key('textFieldEmail')), '');
      await tester.tap(find.byType(ReusableButton));
      await tester.pump();
      expect(find.text('Please Enter email'), findsOneWidget);
    });
    testWidgets('Show error when password is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
      await tester.enterText(find.byKey(Key('textFieldEmail')), 'postman');
      await tester.enterText(find.byKey(Key('textFieldPassword')), '');
      await tester.tap(find.byType(ReusableButton));
      await tester.pump();
      expect(find.text('Please Enter password'), findsOneWidget);
    });
    testWidgets('Show error when email is invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: new LoginScreen()));
      await tester.enterText(find.byKey(Key('textFieldEmail')), 'postman');
      await tester.enterText(find.byKey(Key('textFieldPassword')), '1111');
      await tester.tap(find.byType(ReusableButton));
      await tester.pump();
      expect(find.text('Email is invalid'), findsOneWidget);
    });
    testWidgets('should return true when valid email and password',
        (WidgetTester tester) async {
      var wid = new LoginScreen();
      var st = wid.createState();
      var result = st.validateEmailPassword('postman@gmail.com', '11111');
      expect(result, true);
    });
    testWidgets('should return false when invalid email and password',
        (WidgetTester tester) async {
      var wid = new LoginScreen();
      await tester.pumpWidget(createWidgetForTesting(child: wid));
      var st = tester.state<LoginScreenState>(find.byType(LoginScreen));
      var result = st.validateEmailPassword('postmanil.com', '11111');
      expect(result, false);
    });
  });
}
