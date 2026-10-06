import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huong_dan_flutter_ui/01_quan_ly_cong_viec.dart' as task;
import 'package:huong_dan_flutter_ui/02_dang_nhap.dart' as login;
import 'package:huong_dan_flutter_ui/03_quan_ly_ung_dung.dart' as apps;
import 'package:huong_dan_flutter_ui/04_quan_ly_bai_viet.dart' as posts;
import 'package:huong_dan_flutter_ui/05_quan_ly_san_pham.dart' as products;
import 'package:huong_dan_flutter_ui/06_dang_ky.dart' as register;
import 'package:huong_dan_flutter_ui/07_quan_ly_video.dart' as videos;

void main() {
  final examples = <String, Widget>{
    'tasks': const task.MyApp(),
    'login': const login.MyApp(),
    'apps': const apps.MyApp(),
    'posts': const posts.MyApp(),
    'products': const products.MyApp(),
    'register': const register.MyApp(),
    'videos': const videos.MyApp(),
  };
  for (final entry in examples.entries) {
    for (final width in [320.0, 390.0, 430.0]) {
      testWidgets('${entry.key} at $width: renders and scrolls without overflow', (tester) async {
        tester.view.physicalSize = Size(width, 844);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(entry.value);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.drag(find.byType(ListView), const Offset(0, -1600));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byType(TextField), findsNothing);
        expect(find.byType(Switch), findsNothing);
        expect(find.byType(Checkbox), findsNothing);
      });
    }
  }
}
