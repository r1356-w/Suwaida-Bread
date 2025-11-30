import 'package:flutter/material.dart';
import 'package:suwaida_bread/repositories/auth_repository.dart';
import 'package:suwaida_bread/screens/login_screen.dart';
// تأكد من استيراد شاشة تسجيل الدخول

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // استخدام نفس الـ Repository للوصول إلى دالة تسجيل الخروج
  final _authRepository = AuthRepository();
  bool _isLoggingOut = false;

  // يمكنك إضافة متغيرات لحالة تحميل البيانات المحمية هنا إذا لزم الأمر
  String _welcomeMessage = 'مرحباً بك في الصفحة الرئيسية!';

  Future<void> _logout() async {
    setState(() {
      _isLoggingOut = true;
    });

    try {
      // 1. استدعاء دالة تسجيل الخروج من الـ Repository
      await _authRepository.logout();

      if (mounted) {
        // 2. بعد تسجيل الخروج، يتم الانتقال إلى شاشة تسجيل الدخول
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        // معالجة أي خطأ في عملية تسجيل الخروج (نادرة)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في تسجيل الخروج: ${e.toString()}'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        actions: [
          // زر تسجيل الخروج
          IconButton(
            icon: _isLoggingOut
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : const Icon(Icons.logout),
            onPressed: _isLoggingOut ? null : _logout, // تعطيل الزر أثناء التحميل
            tooltip: 'تسجيل الخروج',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // رسالة الترحيب أو البيانات المحمية
            Text(
              _welcomeMessage,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'لقد تم تسجيل الدخول بنجاح.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}