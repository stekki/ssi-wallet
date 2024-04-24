import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/main.dart';
import 'package:frontend/routes/navigation_helper.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/screens/credential_screen.dart';

void main() {
  testWidgets('Test login',
  (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    NavigationHelper();
    await tester.pumpWidget(MyApp(prefs));

    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('homeScreen')), findsNothing);
    await tester.tap(find.byKey(const ValueKey('developerLoginOptions')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('devTokenSignIn')));
    const token = String.fromEnvironment('TOKEN');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('jwtTokenField')), token);
    await tester.tap(find.byKey(const ValueKey('submitToken')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('homeScreen')), findsOne);
  });
  testWidgets('Test navigation',
  (WidgetTester tester) async {
    /*
    final prefs = await SharedPreferences.getInstance();
    NavigationHelper();
    
    await tester.pumpWidget(MyApp(prefs));
    await tester.pumpAndSettle();
    await tester.pumpWidget(const HomeScreen());
    */

    expect(find.byKey(const ValueKey('profileScreen')), findsNothing);
    expect(find.byType(BottomNavigationBar), findsOne);
    
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('profileScreen')), findsOne);
    
    expect(find.byKey(const ValueKey('CredentialScreen')), findsNothing);
    await tester.tap(find.byIcon(Icons.wallet));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('CredentialScreen')), findsOne);

    
    await tester.tap(find.byIcon(Icons.chat_outlined));
    expect(find.byKey(const ValueKey('homeScreen')), findsOne);
  }
  );
  testWidgets('Test homescreen',
  (WidgetTester tester) async {
    await tester.pumpWidget(const HomeScreen());
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('searchChat')), findsOne);
    expect(find.byKey(const ValueKey('connectionList')), findsOne);
    expect(find.byKey(const ValueKey('addButton')), findsOne);

    await tester.tap(find.byKey(const ValueKey('addButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('tokenInputDialog')), findsOne);
    expect(find.byKey(const ValueKey('invitationLinkField')), findsOne);
    expect(find.byKey(const ValueKey('cancelAddConnection')), findsOne);
    expect(find.byKey(const ValueKey('addConnectionViaLink')), findsOne);

    await tester.tap(find.byKey(const ValueKey('cancelAddConnection')));
    await tester.pumpAndSettle();
  }
  );

  testWidgets('Test profilescreen',
  (WidgetTester tester) async {
    await tester.pumpWidget(const ProfileScreen());
    //await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('profileScreen')), findsOne);
    expect(find.byKey(const ValueKey('invitationLink')), findsOne);
    expect(find.byKey(const ValueKey('regenerateButton')), findsOne);
  });

  testWidgets('Test credential screen', 
  (WidgetTester tester) async {
    await tester.pumpWidget(const CredentialScreen());
    //await tester.tap(find.byIcon(Icons.wallet));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('credentialScreen')), findsOne);
    expect(find.byKey(const ValueKey('searchReceipt')), findsOne);
    expect(find.byKey(const ValueKey('credentialCardList')), findsOne);
  });

}