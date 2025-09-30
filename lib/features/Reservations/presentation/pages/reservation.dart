import 'package:flutter/material.dart';

class ReservationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: Color(0xFF252547),
        title: Text(
          'إدارة الحجوزات',
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
      body: Column(
        children: [
          // العنوان
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Color(0xFF252547),
            child: Text(
              'إدارة الحجوزات',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // قائمة الحجوزات
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الحجوزات القائمة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  SizedBox(height: 16),

                  // بطاقة الحجز الأولى
                  _buildReservationCard(
                    name: 'أمحـد محمد الأمحـد',
                    date: '٩١٤٢ ربيع الأول ٦٦',
                    time: '19:00',
                    location: 'قامة الشبك الكبرى',
                    phone: '-966501234567',
                    type: 'حفل زفاف',
                    price: '300 مييل',
                  ),

                  SizedBox(height: 16),

                  // بطاقة الحجز الثانية
                  _buildReservationCard(
                    name: 'قاطعة علي السعد',
                    date: '٩١٤٢ ربيع الأول ٨٨',
                    time: '20:30',
                    location: 'قامة الشبكة',
                    phone: '-966507654321',
                    type: 'حفل محددة',
                    price: '250 مييل',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildReservationCard({
    required String name,
    required String date,
    required String time,
    required String location,
    required String phone,
    required String type,
    required String price,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF252547),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // المعلومات الأساسية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$date • $time',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF4a3b8c),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // الموقع والهاتف
          Row(
            children: [
              Icon(Icons.location_on, color: Color(0xFF7b68ee), size: 16),
              SizedBox(width: 8),
              Text(
                location,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          Row(
            children: [
              Icon(Icons.phone, color: Color(0xFF7b68ee), size: 16),
              SizedBox(width: 8),
              Text(
                phone,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // السعر وخط الفاصل
          Divider(color: Colors.white24, height: 1),
          SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'السعر',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontFamily: 'Tajawal',
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  color: Color(0xFF7b68ee),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFF252547),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'الرئيسية', false),
          _buildNavItem(Icons.category, 'القطاعات', false),
          _buildNavItem(Icons.calendar_today, 'الحجوزات', true),
          _buildNavItem(Icons.settings, 'المعلم', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Color(0xFF7b68ee) : Colors.white60,
          size: 24,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Color(0xFF7b68ee) : Colors.white60,
            fontSize: 12,
            fontFamily: 'Tajawal',
          ),
        ),
      ],
    );
  }
}
