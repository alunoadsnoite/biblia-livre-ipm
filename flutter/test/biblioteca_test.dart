import 'package:biblia_app/store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'edição livre inicia sem Biblioteca e sem asset de documentos',
    () async {
      SharedPreferences.setMockInitialValues({});
      await AppState.i.load();
      expect(AppState.i.biblioteca, isEmpty);
      expect(AppState.i.loadErrors, isNot(contains('biblioteca')));
      await expectLater(
        rootBundle.loadString('assets/biblioteca.json'),
        throwsA(isA<FlutterError>()),
      );
    },
  );
}
