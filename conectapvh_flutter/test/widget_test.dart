import 'package:flutter_test/flutter_test.dart';
import 'package:conectapvh/main.dart';

void main() {
  testWidgets('app starts and shows the ConectaPVH home', (tester) async {
    await tester.pumpWidget(const ConectaPVHApp());
    expect(find.text('conectaPVH'), findsOneWidget);
    expect(find.text('Boas coisas\nacontecem perto.'), findsOneWidget);
  });
}
