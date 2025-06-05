import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tubes/login.dart';
import 'package:tubes/registrasi_nakes.dart';
import 'package:tubes/theme_provider.dart';

void main() {
  testWidgets('Test Input Yang Benar', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MaterialApp(
          home: RegistrasiNakes(someCondition: true),
        ),
      ),
    );

    // Find fields
    final usernameField = find.byType(TextField).at(0);
    final nameField = find.byType(TextField).at(1);
    final emailField = find.byType(TextField).at(2);
    final passwordField = find.byType(TextField).at(3);
    final strField = find.byType(TextField).at(4);

    // Simulate input
    await tester.enterText(usernameField, 'Nurhaxkes2');
    await tester.enterText(nameField, 'Muhammad Iqbal Nurhaq');
    await tester.enterText(emailField, 'iqbalnur2009@gmail.com');
    await tester.enterText(passwordField, 'AkuDigantungMeniko123');
    await tester.enterText(strField, '2839576');

    // Tap "Daftar"
    final daftarButton = find.widgetWithText(ElevatedButton, 'Daftar');
    expect(daftarButton, findsOneWidget);
    await tester.tap(daftarButton);

    expect(find.byType(AlertDialog), findsNothing);
    await tester.pumpAndSettle();
  });

  testWidgets('Test STR Angka > 7', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MaterialApp(
          home: RegistrasiNakes(someCondition: true),
        ),
      ),
    );

    // Find fields
    final usernameField = find.byType(TextField).at(0);
    final nameField = find.byType(TextField).at(1);
    final emailField = find.byType(TextField).at(2);
    final passwordField = find.byType(TextField).at(3);
    final strField = find.byType(TextField).at(4);

    // Simulate input
    await tester.enterText(usernameField, 'Nurhaxkes2');
    await tester.enterText(nameField, 'Muhammad Iqbal Nurhaq');
    await tester.enterText(emailField, 'iqbalnur2009@gmail.com');
    await tester.enterText(passwordField, 'AkuDigantungMeniko123');
    await tester.enterText(strField, '293847592');

    // Tap "Daftar"
    final daftarButton = find.widgetWithText(ElevatedButton, 'Daftar');
    expect(daftarButton, findsOneWidget);
    await tester.tap(daftarButton);

    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
  });

  testWidgets('Test Input STR < 7', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MaterialApp(
          home: RegistrasiNakes(someCondition: true),
        ),
      ),
    );

    // Find fields
    final usernameField = find.byType(TextField).at(0);
    final nameField = find.byType(TextField).at(1);
    final emailField = find.byType(TextField).at(2);
    final passwordField = find.byType(TextField).at(3);
    final strField = find.byType(TextField).at(4);

    // Simulate input
    await tester.enterText(usernameField, 'Nurhaxkes2');
    await tester.enterText(nameField, 'Muhammad Iqbal Nurhaq');
    await tester.enterText(emailField, 'iqbalnur2009@gmail.com');
    await tester.enterText(passwordField, 'AkuDigantungMeniko123');
    await tester.enterText(strField, '2938');

    // Tap "Daftar"
    final daftarButton = find.widgetWithText(ElevatedButton, 'Daftar');
    expect(daftarButton, findsOneWidget);
    await tester.tap(daftarButton);

    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
  });

  testWidgets('Test No STR', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MaterialApp(
          home: RegistrasiNakes(someCondition: true),
        ),
      ),
    );

    // Find fields
    final usernameField = find.byType(TextField).at(0);
    final nameField = find.byType(TextField).at(1);
    final emailField = find.byType(TextField).at(2);
    final passwordField = find.byType(TextField).at(3);
    final strField = find.byType(TextField).at(4);

    // Simulate input
    await tester.enterText(usernameField, 'Nurhaxkes2');
    await tester.enterText(nameField, 'Muhammad Iqbal Nurhaq');
    await tester.enterText(emailField, 'iqbalnur2009@gmail.com');
    await tester.enterText(passwordField, 'AkuDigantungMeniko123');
    await tester.enterText(strField, '');

    // Tap "Daftar"
    final daftarButton = find.widgetWithText(ElevatedButton, 'Daftar');
    expect(daftarButton, findsOneWidget);
    await tester.tap(daftarButton);

    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
  });
}
