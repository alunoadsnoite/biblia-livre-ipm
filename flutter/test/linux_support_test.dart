import 'package:biblia_app/reminder_settings.dart';
import 'package:biblia_app/tts.dart';
import 'package:biblia_app/tts_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Linux não oferece controles de voz sem implementação', (
    tester,
  ) async {
    expect(TtsService.supported, isFalse);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TtsBar(
            positionLabel: 'Versículo',
            playLabel: 'Ouvir',
            onPlay: () => fail('Voz indisponível no Linux'),
          ),
        ),
      ),
    );
    expect(find.byType(IconButton), findsNothing);
    expect(tester.takeException(), isNull);
  }, variant: TargetPlatformVariant.only(TargetPlatform.linux));

  testWidgets('Linux informa a indisponibilidade de lembretes', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ReminderSettings())),
    );
    expect(
      find.textContaining('ainda não está disponível no Linux'),
      findsOneWidget,
    );
    expect(find.byType(SwitchListTile), findsNothing);
    expect(tester.takeException(), isNull);
  }, variant: TargetPlatformVariant.only(TargetPlatform.linux));
}
