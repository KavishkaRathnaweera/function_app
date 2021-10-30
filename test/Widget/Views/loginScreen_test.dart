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

/*
LoginScreen
 */

/*
testWidgets(
      'should onPhoto handler open camera options',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Builder(
                builder: (BuildContext context) {
                  return AddItemView(
                    gradedItem: GradedItem.generate(),
                    // onPhoto: fn.onPhoto,
                  );
                },
              ),
            ),
          ),
        );
 */

// await tester.tap(find.byType(MaterialButton));
// expect(find.byWidget(Text('Test')), findsOneWidget);
// expect(find.byType(ElevatedButton), findsOneWidget);
// await tester.tap(find.byType(ElevatedButton));
// await tester.pumpAndSettle();
//
// expect(find.byWidget(PostmanScreen()), findsOneWidget);

//final im = find.widgetWithIcon(CircleAvatar, icon)
// Enter 'hi' into the TextField.
// await tester.enterText(find.byType(TextField), 'hi');

// Tap the add button.
// await tester.tap(find.byType(FloatingActionButton));

// Rebuild the widget with the new item.
//  await tester.pump();

// Expect to find the item on screen.
//expect(find.text('POSTMAN'), findsOneWidget);

// Swipe the item to dismiss it.
// await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));

// Build the widget until the dismiss animation ends.
//  await tester.pumpAndSettle();

// Ensure that the item is no longer on screen.
//  expect(find.text('hi'), findsNothing);
