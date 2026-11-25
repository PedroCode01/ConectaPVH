import 'package:flutter_test/flutter_test.dart';
import 'package:conecta_pvh/main.dart';

void main() {
  testWidgets('ConectaPVHApp inicializa sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const ConectaPVHApp());
    await tester.pump();
    expect(find.byType(ConectaPVHApp), findsOneWidget);
  });
}
