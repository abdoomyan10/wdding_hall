import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:wedding_hall/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:wedding_hall/features/auth/domain/entities/user.dart';
import 'package:wedding_hall/features/home/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRepositoryImpl _authRepository =
      GetIt.instance<AuthRepositoryImpl>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  void _login() {
    String email = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى ملء جميع الحقول',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7b68ee)),
        ),
      ),
      barrierDismissible: false,
    );

    _authRepository
        .signInWithEmail(email, password)
        .then((user) {
          Get.back();
          if (user != null) {
            Get.offAll(() => DashboardScreen());
          } else {
            Get.snackbar(
              'خطأ',
              'فشل تسجيل الدخول. تحقق من البيانات.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        })
        .catchError((e) {
          Get.back();
          Get.snackbar(
            'خطأ',
            'حدث خطأ أثناء تسجيل الدخول: ${e.toString()}',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header Section
                SizedBox(height: 40),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF4a3b8c),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Color(0xFF7b68ee).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Icon(Icons.place, color: Colors.white, size: 40),
                ),
                SizedBox(height: 20),
                Text(
                  'قصر الأقراح',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 40),

                // Login Form
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF252547),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Username Field
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'اسم المستخدم',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Tajawal',
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFF7b68ee),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF7b68ee)),
                          ),
                          filled: true,
                          fillColor: Color(0xFF2d2d5a),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      SizedBox(height: 20),

                      // Password Field
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Tajawal',
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF7b68ee),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF7b68ee),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF7b68ee)),
                          ),
                          filled: true,
                          fillColor: Color(0xFF2d2d5a),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      SizedBox(height: 20),

                      // Remember Me & Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                                activeColor: Color(0xFF7b68ee),
                              ),
                              Text(
                                'تذكرني',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // إضافة منطق استعادة كلمة المرور
                            },
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(
                                color: Color(0xFF7b68ee),
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF7b68ee),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Footer
                Text(
                  'جميع الحقوق محفوظة © 2024',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
