// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:protocolo_app/src/view/criarProtocolo/criarProtocolo.dart'
    as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Criar Protocolo E2E Test', () {
    testWidgets('Digite o nome vinicius silva rodrigues no campo do Veículo',
        (WidgetTester tester) async {
      app.CriarProtocolo();
      await tester.pumpAndSettle();

      await tester.tap(find.bySemanticsLabel('Digite o motorista'));
      await Future.delayed(Duration(seconds: 1));

      await tester.pumpAndSettle();

      expect(find.text('VINICIUS SILVA RODRIGUES FRANCA'), findsOneWidget);
    });
  });
}
