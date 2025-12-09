import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uterine_cancer_flutter_app/screens/login_screen.dart';
import 'package:uterine_cancer_flutter_app/services/auth_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        // Add other providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق التنبؤ بسرطان الرحم',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // دعم اللغة العربية
        fontFamily: 'Arial', // يجب استبداله بخط يدعم العربية
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Arial'),
          bodyMedium: TextStyle(fontFamily: 'Arial'),
          titleLarge: TextStyle(fontFamily: 'Arial'),
        ),
        useMaterial3: true,
      ),
      // تحديد اتجاه النص من اليمين لليسار (RTL)
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const LoginScreen(),
    );
  }
}
