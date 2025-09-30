import 'package:flutter/material.dart';
import 'package:wedding_hall/features/Expenses/presentation/pages/expenses.dart';
import 'package:wedding_hall/features/Reservations/presentation/pages/reservation.dart';
import 'package:wedding_hall/features/setting/presentation/pages/setting.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ExpensesScreen(),
    ReservationsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: Color(0xFF252547),
        title: Text(
          'لوحة التحكم',
          style: TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF252547),
        selectedItemColor: Color(0xFF7b68ee),
        unselectedItemColor: Colors.white60,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'القطاعات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'الحجوزات',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'المعلم'),
        ],
      ),
    );
  }
}

// Placeholder widgets for each tab
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'الرئيسية',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'Tajawal',
        ),
      ),
    );
  }
}
