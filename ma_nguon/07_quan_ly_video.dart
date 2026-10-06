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
          title: const Text('Quản lý video',
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

Widget videoThumbnail(IconData icon, String duration) {
  return SizedBox(
    width: 116, height: 86,
    child: Stack(alignment: Alignment.center, children: [
      Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFFCCE3FF), Color(0xFF9FC7FC)]),
          borderRadius: BorderRadius.circular(10)),
        child: Center(child: Icon(icon, size: 65, color: Color(0xFF679DE3))),
      ),
      Container(width: 36, height: 36,
        decoration: const BoxDecoration(color: Color(0xAA183E68), shape: BoxShape.circle),
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 27)),
      Positioned(right: 4, bottom: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(color: const Color(0xBB183E68),
            borderRadius: BorderRadius.circular(5)),
          child: Text(duration, style: const TextStyle(color: Colors.white, fontSize: 11)),
        )),
    ]),
  );
}

Widget videoRow(String title, String info, String duration,
    IconData thumbnail, String status, Color color, IconData statusIcon) {
  return card(Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    videoThumbnail(thumbnail, duration),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Text(title, style: const TextStyle(
          color: ink, fontSize: 15, fontWeight: FontWeight.bold))),
        const Icon(Icons.more_vert, color: muted, size: 20),
      ]),
      const SizedBox(height: 8),
      Text(info, style: const TextStyle(color: muted, fontSize: 11)),
      const SizedBox(height: 10),
      badge(status, color, icon: statusIcon),
    ])),
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
      searchVisual('Tìm kiếm video...'),
      const SizedBox(height: 18),
      filters(['Tất cả', 'Công khai', 'Riêng tư', 'Bản nháp']),
      const SizedBox(height: 20),
      videoRow('Giới thiệu về UniApp', '12 thg 6, 2024 • 123 lượt xem', '05:20',
        Icons.landscape, 'Công khai', green, Icons.public),
      videoRow('Hướng dẫn đăng ký tài khoản', '10 thg 6, 2024 • 56 lượt xem', '08:15',
        Icons.laptop, 'Công khai', green, Icons.public),
      videoRow('Làm quen với giao diện', '8 thg 6, 2024 • 34 lượt xem', '12:43',
        Icons.article, 'Riêng tư', red, Icons.lock_outline),
      videoRow('Mẹo học tập hiệu quả', '5 thg 6, 2024 • 91 lượt xem', '06:30',
        Icons.school, 'Bản nháp', muted, Icons.insert_drive_file_outlined),
    ],
  );
}
