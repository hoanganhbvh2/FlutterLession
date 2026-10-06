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
          title: const Text('Quản lý sản phẩm',
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

Widget actionVisual(IconData icon, Color color) {
  return Container(
    width: 35, height: 35,
    decoration: BoxDecoration(color: color.withAlpha(24),
      borderRadius: BorderRadius.circular(9)),
    child: Icon(icon, color: color, size: 22),
  );
}

Widget productRow(String name, String price, String stock, IconData icon) {
  return card(Row(children: [
    illustration(icon, size: 78),
    const SizedBox(width: 14),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: const TextStyle(
        color: ink, fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 7),
      Text(price, style: const TextStyle(
        color: blue, fontSize: 17, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text('Tồn kho: $stock', style: const TextStyle(color: muted, fontSize: 14)),
    ])),
    const SizedBox(width: 8),
    Column(children: [
      actionVisual(Icons.edit_outlined, blue),
      const SizedBox(height: 8),
      actionVisual(Icons.delete_outline, red),
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
      searchVisual('Tìm kiếm sản phẩm...'),
      const SizedBox(height: 18),
      filters(['Tất cả', 'Điện tử', 'Sách', 'Khác'], rounded: false),
      const SizedBox(height: 20),
      productRow('Laptop ASUS VivoBook', '12.990.000 đ', '15', Icons.laptop_mac),
      productRow('Điện thoại iPhone 15', '22.990.000 đ', '8', Icons.smartphone),
      productRow('Sách Flutter Cơ Bản', '199.000 đ', '50', Icons.menu_book),
      productRow('Tai nghe Bluetooth', '890.000 đ', '20', Icons.headphones),
    ],
  );
}
