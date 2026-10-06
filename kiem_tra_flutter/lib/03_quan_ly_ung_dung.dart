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
          title: const Text('Quản lý ứng dụng',
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

// Vẽ trạng thái bật bằng hình viên thuốc và hình tròn trắng.
Widget switchVisual() {
  return Container(
    width: 52, height: 29,
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(20)),
    alignment: Alignment.centerRight,
    child: Container(width: 23, height: 23,
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
  );
}

Widget appRow(String name, String version, IconData icon, Color color,
    {bool update = false}) {
  return card(Row(children: [
    Container(
      width: 58, height: 58,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
      child: Icon(icon, color: Colors.white, size: 34),
    ),
    const SizedBox(width: 14),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: const TextStyle(
        color: ink, fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Text('Phiên bản $version', style: const TextStyle(color: muted, fontSize: 13)),
    ])),
    const SizedBox(width: 8),
    if (update)
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF3FF),
          border: Border.all(color: blue),
          borderRadius: BorderRadius.circular(10)),
        child: const Text('Cập nhật', style: TextStyle(color: blue, fontSize: 13)),
      )
    else
      switchVisual(),
  ]));
}

Widget buildContent() {
  return ListView(
    padding: const EdgeInsets.all(14),
    children: [
      Row(children: [
        stat('5', 'Tổng ứng dụng', Icons.grid_view_rounded, blue),
        const SizedBox(width: 10),
        stat('4', 'Đang hoạt động', Icons.check_circle, green),
        const SizedBox(width: 10),
        stat('1', 'Cần cập nhật', Icons.arrow_upward, orange),
      ]),
      const SizedBox(height: 18),
      appRow('UniApp LMS', '1.2.0', Icons.school, blue),
      appRow('Quản lý sinh viên', '1.0.3', Icons.groups, green),
      appRow('Lịch học', '1.1.0', Icons.calendar_month, orange, update: true),
      appRow('Thông báo', '1.0.5', Icons.chat_bubble, const Color(0xFF8158E8)),
      appRow('Cài đặt hệ thống', '1.0.0', Icons.settings, red),
    ],
  );
}
