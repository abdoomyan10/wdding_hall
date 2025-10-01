import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';
import 'package:wedding_hall/features/auth/presentation/pages/splash_screen.dart';
import 'package:wedding_hall/firebase_options.dart';
import 'package:wedding_hall/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:wedding_hall/features/auth/data/repositories/auth_repository_impl.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register your services, cubits, repositories, etc. here
  locator.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(),
  );
  locator.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(locator<FirebaseAuthDataSource>()),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'قصر الأقراح',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Tajawal'),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
