import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_flutter/main.dart';

void main() {
  testWidgets('Exibe os campos do formulário de cadastro', (tester) async {
    await tester.pumpWidget(const CadastroApp());

    expect(find.text('Nome completo'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('CPF'), findsOneWidget);
    expect(find.text('Telefone'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('CADASTRAR'), findsOneWidget);
  });
}
