import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:wedding_hall/firebase_options.dart';

final GetIt locator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Wedding Hall")));
  }
}
