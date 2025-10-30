import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aplikasi_flutter/screens/login_screen.dart';
import 'package:aplikasi_flutter/services/db_service.dart';
import 'package:aplikasi_flutter/services/auth_service.dart';
import 'package:aplikasi_flutter/screens/product_list_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ Inisialisasi database lokal (SQLite)
  await DBService.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService.instance),
        ChangeNotifierProvider(create: (_) => DBService.instance),
      ],
      child: Consumer<AuthService>(
        builder: (context, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(
              colorScheme: ThemeData.dark().colorScheme.copyWith(
                primary: Colors.tealAccent,
              ),
            ),
            home: auth.isLoggedIn
                ? const ProductListScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
