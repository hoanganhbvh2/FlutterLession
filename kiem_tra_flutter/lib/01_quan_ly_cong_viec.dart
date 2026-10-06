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
          title: const Text('Quản lý công việc',
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

Widget stat(String number, String label, IconData icon, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        border: Border.all(color: line),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: color.withAlpha(25), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 25),
        ),
        const SizedBox(height: 8),
        Text(number, style: const TextStyle(
          color: ink, fontSize: 27, fontWeight: FontWeight.bold)),
        const SizedBox(height: 3),
        Text(label, textAlign: TextAlign.center,
          style: const TextStyle(color: muted, fontSize: 12)),
      ]),
    ),
  );
}

Widget taskRow(String title, String date, String status, Color color,
    {bool checked = false}) {
  return card(Row(children: [
    Container(
      width: 23, height: 23,
      decoration: BoxDecoration(
        color: checked ? blue : Colors.white,
        border: Border.all(color: checked ? blue : muted, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: checked ? const Icon(Icons.check, color: Colors.white, size: 19) : null,
    ),
    const SizedBox(width: 14),
    Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(
          color: ink, fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(children: [
          const Icon(Icons.calendar_today_outlined, size: 16, color: muted),
          const SizedBox(width: 6),
          Expanded(child: Text(date,
            style: const TextStyle(color: muted, fontSize: 12))),
        ]),
      ],
    )),
    const SizedBox(width: 8),
    badge(status, color),
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
      Row(children: [
        stat('5', 'Hôm nay', Icons.calendar_month, blue),
        const SizedBox(width: 10),
        stat('2', 'Đã xong', Icons.check_circle, green),
        const SizedBox(width: 10),
        stat('2', 'Đang làm', Icons.access_time_filled, orange),
      ]),
      const SizedBox(height: 22),
      const Row(children: [
        Expanded(child: Text('Danh sách công việc', style: TextStyle(
          color: ink, fontSize: 19, fontWeight: FontWeight.bold))),
        Text('Tất cả', style: TextStyle(color: blue, fontSize: 15)),
        SizedBox(width: 4),
        Icon(Icons.keyboard_arrow_down, color: blue),
      ]),
      const SizedBox(height: 14),
      taskRow('Hoàn thành báo cáo', 'Hôm nay, 17 thg 4', 'Quan trọng', red, checked: true),
      taskRow('Họp nhóm dự án', 'Hôm nay, 17 thg 4', 'Đang làm', blue),
      taskRow('Đọc tài liệu Flutter', 'Hôm qua, 16 thg 4', 'Đã xong', green, checked: true),
      taskRow('Thiết kế giao diện', 'Ngày mai, 18 thg 4', 'Bình thường', orange),
      taskRow('Chuẩn bị thuyết trình', '20 thg 4, 2024', 'Quan trọng', red),
    ],
  );
}
