//import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/material.dart';
//import 'package:wedding_hall/firebase_options.dart';
//import 'package:wedding_hall/presentation/pages/main_page.dart';



/*void main() async {

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:MainPage(),

    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'injection_container.dart' as di; // تأكد من أن هذا هو ملف DI
import 'firebase_options.dart'; // ملف إعدادات Firebase
import 'presentation/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🧠 تهيئة الاعتمادات (Dependency Injection)
  await di.init();

  // 🚀 تشغيل التطبيق
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HomeCubit>(
        create: (_) => di.sl<HomeCubit>(),
        child: const MainPage(),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/payments/presentation/cubit/payment_cubit.dart'; // ✅ استيراد PaymentCubit
import 'injection_container.dart' as di;
import 'firebase_options.dart';
import 'presentation/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 🔥 تهيئة Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 🧠 تهيئة dependency injection
    await di.init();

    // 🚀 تشغيل التطبيق
    runApp(const MainApp());
  } catch (e) {
    print('Error in main: $e');
    runApp(ErrorApp(error: e.toString()));
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => di.sl<HomeCubit>()..loadHomeData(),
        ),
        BlocProvider<PaymentCubit>(
          create: (context) => di.sl<PaymentCubit>()..loadPayments(), // ✅ إذا كان هناك دالة تحميل
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MainPage(),
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String error;

  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}