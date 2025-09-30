import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  bool _autoBackupEnabled = false;
  String _selectedLanguage = 'العربية';
  String _selectedTheme = 'مظلم';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: Color(0xFF252547),
        title: Text(
          'الإعدادات',
          style: TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Color(0xFF7b68ee)),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // بطاقة الإعدادات العامة
            _buildSettingsCard(
              title: 'الإعدادات العامة',
              icon: Icons.settings,
              children: [
                _buildSettingItem(
                  icon: Icons.language,
                  title: 'اللغة',
                  subtitle: 'اختر لغة التطبيق',
                  trailing: _buildLanguageDropdown(),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.palette,
                  title: 'المظهر',
                  subtitle: 'اختر نمط التطبيق',
                  trailing: _buildThemeDropdown(),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.backup,
                  title: 'النسخ الاحتياطي التلقائي',
                  subtitle: 'نسخ البيانات تلقائياً',
                  trailing: Switch(
                    value: _autoBackupEnabled,
                    onChanged: (value) {
                      setState(() {
                        _autoBackupEnabled = value;
                      });
                    },
                    activeColor: Color(0xFF7b68ee),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // بطاقة الإشعارات
            _buildSettingsCard(
              title: 'الإشعارات',
              icon: Icons.notifications,
              children: [
                _buildSettingItem(
                  icon: Icons.notifications_active,
                  title: 'تفعيل الإشعارات',
                  subtitle: 'استقبال الإشعارات والتحديثات',
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: Color(0xFF7b68ee),
                  ),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.email,
                  title: 'الإشعارات البريدية',
                  subtitle: 'إشعارات عبر البريد الإلكتروني',
                  trailing: Switch(
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                    activeColor: Color(0xFF7b68ee),
                  ),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.calendar_today,
                  title: 'تذكير الحجوزات',
                  subtitle: 'تذكير قبل الموعد بـ 24 ساعة',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Color(0xFF7b68ee),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // بطاقة الحساب
            _buildSettingsCard(
              title: 'الحساب',
              icon: Icons.person,
              children: [
                _buildSettingItem(
                  icon: Icons.security,
                  title: 'خصوصية البيانات',
                  subtitle: 'إدارة إعدادات الخصوصية',
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                  onTap: () => _showPrivacySettings(),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.lock,
                  title: 'تغيير كلمة المرور',
                  subtitle: 'تحديث كلمة المرور الحالية',
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                  onTap: () => _changePassword(),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.visibility,
                  title: 'نشاط الحساب',
                  subtitle: 'عرض سجل النشاطات',
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                  onTap: () => _showActivityLog(),
                ),
              ],
            ),

            SizedBox(height: 20),

            // بطاقة حول التطبيق
            _buildSettingsCard(
              title: 'حول التطبيق',
              icon: Icons.info,
              children: [
                _buildSettingItem(
                  icon: Icons.star,
                  title: 'تقييم التطبيق',
                  subtitle: 'قيمنا في متجر التطبيقات',
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                  onTap: () => _rateApp(),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.share,
                  title: 'مشاركة التطبيق',
                  subtitle: 'شارك التطبيق مع الأصدقاء',
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                  onTap: () => _shareApp(),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.help,
                  title: 'مركز المساعدة',
                  subtitle: 'الدعم والاستفسارات',
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                  onTap: () => _showHelpCenter(),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.description,
                  title: 'شروط الخدمة',
                  subtitle: 'الشروط والأحكام',
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                  onTap: () => _showTerms(),
                ),
              ],
            ),

            SizedBox(height: 20),

            // معلومات الإصدار
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF252547),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الإصدار',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'الإصدار 1.0.0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                      'الأحدث',
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
            ),

            SizedBox(height: 20),

            // زر تسجيل الخروج
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
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
        children: [
          // رأس البطاقة
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white24, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Color(0xFF7b68ee), size: 20),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
          // محتوى البطاقة
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF4a3b8c).withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Color(0xFF7b68ee), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Tajawal',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12,
          fontFamily: 'Tajawal',
        ),
      ),
      trailing: trailing,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: Colors.white24, height: 1),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _selectedLanguage,
        icon: Icon(Icons.arrow_drop_down, color: Color(0xFF7b68ee)),
        dropdownColor: Color(0xFF252547),
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Tajawal',
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedLanguage = newValue!;
          });
        },
        items: <String>['العربية', 'English', 'Français']
            .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            })
            .toList(),
      ),
    );
  }

  Widget _buildThemeDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _selectedTheme,
        icon: Icon(Icons.arrow_drop_down, color: Color(0xFF7b68ee)),
        dropdownColor: Color(0xFF252547),
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Tajawal',
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedTheme = newValue!;
          });
        },
        items: <String>['مظلم', 'فاتح', 'تلقائي'].map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          },
        ).toList(),
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
          _buildNavItem(Icons.calendar_today, 'الحجوزات', false),
          _buildNavItem(Icons.settings, 'المعلم', true),
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

  // دوال الإعدادات
  void _saveSettings() {
    // حفظ الإعدادات
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم حفظ الإعدادات بنجاح',
          style: TextStyle(fontFamily: 'Tajawal'),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF252547),
          title: Text(
            'تسجيل الخروج',
            style: TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
          ),
          content: Text(
            'هل أنت متأكد من تسجيل الخروج؟',
            style: TextStyle(color: Colors.white70, fontFamily: 'Tajawal'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'إلغاء',
                style: TextStyle(color: Colors.white70, fontFamily: 'Tajawal'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // تنفيذ تسجيل الخروج
              },
              child: Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.red, fontFamily: 'Tajawal'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacySettings() {
    // عرض إعدادات الخصوصية
  }

  void _changePassword() {
    // تغيير كلمة المرور
  }

  void _showActivityLog() {
    // عرض سجل النشاط
  }

  void _rateApp() {
    // تقييم التطبيق
  }

  void _shareApp() {
    // مشاركة التطبيق
  }

  void _showHelpCenter() {
    // مركز المساعدة
  }

  void _showTerms() {
    // شروط الخدمة
  }
}
