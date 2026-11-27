import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_layout_flutter/main.dart';
import 'package:tugas_layout_flutter/profile_card.dart';

void main() {
  testWidgets('ProfileCard renders with NIM 20240801144 formulas and theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verifikasi teks utama
    expect(find.text('Kartu Praktikan'), findsOneWidget);
    expect(find.text('NIM : 20240801144'), findsOneWidget);
    expect(find.text('Skor Aktivitas : 94'), findsOneWidget);

    // Verifikasi Scaffold background color (digit terakhir 4 = genap -> Colors.amber[100])
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.theme?.scaffoldBackgroundColor, Colors.amber[100]);

    // Verifikasi FlutterLogo size = 60.0 + (4 * 2) = 68.0
    final FlutterLogo logo = tester.widget(find.byType(FlutterLogo));
    expect(logo.size, 68.0);

    // Verifikasi Divider thickness = 1.5
    final Divider divider = tester.widget(find.byType(Divider));
    expect(divider.thickness, 1.5);

    // Verifikasi lebar kartu = 320.0 + (4 * 5) = 340.0 dan borderRadius = 12.0 + (4 * 1.5) = 18.0
    final Container rootCard = tester.widget(
      find.descendant(
        of: find.byType(ProfileCard),
        matching: find.byType(Container),
      ).first,
    );
    expect(rootCard.constraints?.minWidth, 340.0);
    final BoxDecoration decoration = rootCard.decoration! as BoxDecoration;
    expect(decoration.color, Colors.white);
    expect(decoration.borderRadius, BorderRadius.circular(18.0));
    expect(decoration.boxShadow?.first.blurRadius, 10.0);

    // Verifikasi jarak pemisah horizontal = 15.0 + 4 = 19.0
    final Finder spacingFinder = find.byWidgetPredicate(
      (Widget widget) => widget is SizedBox && widget.width == 19.0,
    );
    expect(spacingFinder, findsOneWidget);
  });
}
