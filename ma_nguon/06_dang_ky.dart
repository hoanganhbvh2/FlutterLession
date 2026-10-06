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
          title: const Text('UniApp',
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

Widget educationLogo() {
  return Container(
    width: 170, height: 170,
    decoration: const BoxDecoration(
      shape: BoxShape.circle, color: Color(0xFFF0F6FF)),
    child: const Stack(
      alignment: Alignment.center,
      children: [
        Positioned(bottom: 22,
          child: Icon(Icons.menu_book_rounded, size: 90, color: orange)),
        Positioned(top: 20,
          child: Icon(Icons.school_rounded, size: 112, color: Color(0xFF305D9E))),
      ],
    ),
  );
}

// Ô giả lập: không mở bàn phím, không nhập liệu.
Widget inputVisual(String hint, IconData icon, {bool eye = false}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    decoration: BoxDecoration(
      color: const Color(0xFFF6F7F9),
      border: Border.all(color: const Color(0xFFE1E5EC)),
      borderRadius: BorderRadius.circular(13),
    ),
    child: Row(children: [
      Icon(icon, color: const Color(0xFF59647C), size: 25),
      const SizedBox(width: 16),
      Expanded(child: Text(hint,
        style: const TextStyle(color: muted, fontSize: 17))),
      if (eye) const Icon(Icons.visibility_outlined, color: Color(0xFF59647C)),
    ]),
  );
}

Widget buttonVisual(String label, {bool outline = false}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 17),
    decoration: BoxDecoration(
      color: outline ? Colors.white : blue,
      border: Border.all(color: blue),
      borderRadius: BorderRadius.circular(13),
    ),
    child: Text(label, textAlign: TextAlign.center, style: TextStyle(
      color: outline ? blue : Colors.white,
      fontSize: 18, fontWeight: FontWeight.bold)),
  );
}

Widget buildContent() {
  return ListView(
    padding: const EdgeInsets.fromLTRB(22, 32, 22, 28),
    children: [
      Center(child: educationLogo()),
      const SizedBox(height: 20),
      const Text('Đăng ký', textAlign: TextAlign.center,
        style: TextStyle(color: ink, fontSize: 36, fontWeight: FontWeight.bold)),
      const SizedBox(height: 28),
      inputVisual('Họ tên', Icons.person_outline),
      inputVisual('Email', Icons.mail_outline),
      inputVisual('Mật khẩu', Icons.lock_outline, eye: true),
      inputVisual('Xác nhận mật khẩu', Icons.lock_outline, eye: true),
      const SizedBox(height: 10),
      buttonVisual('Tạo tài khoản'),
      const SizedBox(height: 20),
      const Text.rich(
        TextSpan(children: [
          TextSpan(text: 'Đã có tài khoản? ', style: TextStyle(color: muted)),
          TextSpan(text: 'Đăng nhập', style: TextStyle(color: blue)),
        ]),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}
