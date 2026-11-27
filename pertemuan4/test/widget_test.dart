import 'package:flutter_test/flutter_test.dart';

import 'package:pertemuan4/main.dart';
import 'package:pertemuan4/widgets/app_button.dart';

void main() {
  testWidgets('Profile card renders identity and GitHub button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Calvin Ananta Pratama'), findsOneWidget);
    expect(find.text('NIM: 20240801144'), findsOneWidget);
    expect(find.text('Program Studi: Teknik Informatika'), findsOneWidget);
    expect(find.text('Kunjungi GitHub Saya'), findsOneWidget);
    expect(find.byType(AppButton), findsOneWidget);
  });
}
