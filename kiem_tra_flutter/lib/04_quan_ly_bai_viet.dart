import 'package:flutter/material.dart';

const blue = Color(0xFF2F7BEA);
const ink = Color(0xFF101735);
const muted = Color(0xFF7D879D);
const line = Color(0xFFE7EBF2);
const green = Color(0xFF20AD70);
const orange = Color(0xFFFFA116);
const red = Color(0xFFFF4E58);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý bài viết',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          backgroundColor: blue,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          toolbarHeight: 76,
          titleSpacing: 20,
        ),
        body: SafeArea(
          top: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: buildContent(),
            ),
          ),
        ),
        floatingActionButton: addVisual(),
      ),
    );
  }
}

// Khung dùng cho từng dòng dữ liệu.
Widget card(Widget child) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: line),
      borderRadius: BorderRadius.circular(16),
    ),
    child: child,
  );
}

// Nhãn màu chỉ hiển thị một trạng thái đã cho sẵn.
Widget badge(String text, Color color, {IconData? icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      runSpacing: 3,
      children: [
        if (icon != null)
          Icon(icon, size: 16, color: color),
        Text(text, style: TextStyle(color: color, fontSize: 12)),
      ],
    ),
  );
}

Widget searchVisual(String hint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F6F8),
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: line),
    ),
    child: Row(children: [
      const Icon(Icons.search, color: muted, size: 26),
      const SizedBox(width: 12),
      Expanded(child: Text(hint,
          style: const TextStyle(color: muted, fontSize: 16))),
    ]),
  );
}

Widget filters(List<String> labels, {bool rounded = true}) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (int i = 0; i < labels.length; i++)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          decoration: BoxDecoration(
            color: i == 0 ? blue : const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(rounded ? 24 : 10),
            border: Border.all(color: i == 0 ? blue : line),
          ),
          child: Text(labels[i], style: TextStyle(
            color: i == 0 ? Colors.white : muted, fontSize: 14)),
        ),
    ],
  );
}

// Minh họa bằng icon có sẵn, không cần tải ảnh hay cài thư viện.
Widget illustration(IconData icon, {Color color = blue, double size = 72}) {
  return Container(
    width: size, height: size,
    decoration: BoxDecoration(
      color: color.withAlpha(24),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon, color: color, size: size * 0.58),
  );
}

Widget postRow(String title, String category, String date,
    IconData icon, {bool draft = false}) {
  return card(Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    illustration(icon, color: draft ? orange : blue, size: 66),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(
        color: ink, fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text(category, style: const TextStyle(color: muted, fontSize: 13)),
      const SizedBox(height: 6),
      Row(children: [
        const Icon(Icons.calendar_today_outlined, size: 15, color: muted),
        const SizedBox(width: 4),
        Expanded(child: Text(date, style: const TextStyle(color: muted, fontSize: 11))),
      ]),
    ])),
    const SizedBox(width: 8),
    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      badge(draft ? 'Bản nháp' : 'Đã đăng', draft ? orange : green),
      const SizedBox(height: 22),
      const Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.edit_outlined, size: 22, color: muted),
        SizedBox(width: 16),
        Icon(Icons.delete_outline, size: 22, color: red),
      ]),
    ]),
  ]));
}

// Hình tròn có dấu cộng; đây không phải nút có sự kiện.
Widget addVisual() {
  return Container(
    width: 62,
    height: 62,
    decoration: const BoxDecoration(
      color: blue,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(color: Color(0x26000000), blurRadius: 16, offset: Offset(0, 7)),
      ],
    ),
    child: const Icon(Icons.add, size: 34, color: Colors.white),
  );
}

Widget buildContent() {
  return ListView(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 94),
    children: [
      searchVisual('Tìm kiếm bài viết...'),
      const SizedBox(height: 16),
      filters(['Tất cả', 'Đã đăng', 'Bản nháp']),
      const SizedBox(height: 16),
      postRow('Hướng dẫn bắt đầu với Flutter', 'Công nghệ', '12 thg 4, 2024', Icons.landscape),
      postRow('10 mẹo học tập hiệu quả', 'Giáo dục', '10 thg 4, 2024', Icons.eco, draft: true),
      postRow('Làm việc từ xa hiệu quả', 'Kỹ năng', '5 thg 4, 2024', Icons.laptop),
      postRow('Top 5 cuốn sách nên đọc', 'Đời sống', '1 thg 4, 2024', Icons.menu_book),
      postRow('Tư duy tích cực mỗi ngày', 'Phát triển bản thân', '28 thg 3, 2024',
        Icons.lightbulb, draft: true),
    ],
  );
}
