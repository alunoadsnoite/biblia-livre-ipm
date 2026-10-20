import 'dart:io';
import 'dart:ui' as ui;

import 'package:biblia_app/main.dart';
import 'package:biblia_app/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final font = FontLoader('Roboto');
    font.addFont(
      Future.value(
        ByteData.sublistView(
          await File(Platform.environment['FDROID_SCREENSHOT_FONT']!)
              .readAsBytes(),
        ),
      ),
    );
    await font.load();
    final icons = FontLoader('MaterialIcons');
    icons.addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    // This opt-in generator runs under flutter test, never in the app.
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    await AppState.i.load();
  });
  testWidgets('capture real app screens for F-Droid metadata', (tester) async {
    tester.view.physicalSize = const Size(432, 960);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    const key = ValueKey('capture');
    await tester.pumpWidget(
      const RepaintBoundary(key: key, child: BibliaApp()),
    );
    await tester.pumpAndSettle();
    Future<void> capture(String name) async {
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byKey(key),
      );
      final image = await boundary.toImage(pixelRatio: 2);
      final data = await tester.runAsync(
        () => image.toByteData(format: ui.ImageByteFormat.png),
      );
      final output = Directory(
        '../fastlane/metadata/android/pt-BR/images/phoneScreenshots',
      );
      output.createSync(recursive: true);
      File('${output.path}/$name.png')
          .writeAsBytesSync(data!.buffer.asUint8List());
      image.dispose();
    }

    await capture('1-bible');
    await tester.tap(find.text('Hinário'));
    await tester.pumpAndSettle();
    expect(find.text('Salmos e Hinos (1880)'), findsOneWidget);
    expect(find.text('Hinário Novo Cântico'), findsNothing);
    await capture('2-hymnal');
    await tester.tap(find.text('Mais'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Config'));
    await tester.pumpAndSettle();
    await capture('3-settings');
  });
}
