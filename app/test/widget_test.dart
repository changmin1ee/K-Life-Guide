import 'package:flutter_test/flutter_test.dart';
import 'package:k_life_guide/main.dart';

void main() {
  testWidgets('K-Life Guide login screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const KLifeGuideApp());

    expect(find.text('한국 생활을\n미션처럼 쉽게'), findsOneWidget);
    expect(find.text('Google 계정으로 계속하기'), findsOneWidget);
  });
}
