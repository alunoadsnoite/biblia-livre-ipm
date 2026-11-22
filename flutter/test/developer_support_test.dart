import 'package:biblia_app/store.dart';
import 'package:biblia_app/tabs/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AppState.i.load();
  });

  testWidgets('Pix is copied only when requested and confirms the action', (
    tester,
  ) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SettingsTab())),
    );
    expect(copied, isNull);
    await tester.scrollUntilVisible(find.text('Copiar chave Pix'), 300);
    await tester.tap(find.text('Copiar chave Pix'));
    await tester.pumpAndSettle();
    expect(copied, '81063e93-0c1b-4ddb-8a16-b9be68a75d4e');
    expect(find.text('Chave Pix copiada.'), findsOneWidget);
  });

  testWidgets(
    'a failed browser launch reports an error without leaving settings',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsTab(
              openExternalUrl: (uri) async {
                expect(
                  uri.toString(),
                  'https://github.com/sponsors/alunoadsnoite',
                );
                return false;
              },
            ),
          ),
        ),
      );
      await tester.scrollUntilVisible(find.text('GitHub Sponsors'), 300);
      await tester.tap(find.text('GitHub Sponsors'));
      await tester.pumpAndSettle();
      expect(
        find.text('Não foi possível abrir o GitHub Sponsors.'),
        findsOneWidget,
      );
      expect(find.byType(SettingsTab), findsOneWidget);
    },
  );
}
