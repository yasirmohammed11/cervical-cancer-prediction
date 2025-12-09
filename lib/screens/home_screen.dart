import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uterine_cancer_flutter_app/services/auth_service.dart';
import 'package:uterine_cancer_flutter_app/screens/login_screen.dart';
import 'package:uterine_cancer_flutter_app/screens/prediction_form_screen.dart';
import 'package:uterine_cancer_flutter_app/screens/history_screen.dart';
import 'package:uterine_cancer_flutter_app/screens/about_screen.dart';
import 'package:uterine_cancer_flutter_app/screens/guide_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PredictionFormScreen(),
    HistoryScreen(),
    GuideScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تطبيق التنبؤ بسرطان الرحم'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await authService.logout();
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'السجل',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'الدليل',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'عن البرنامج',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
