import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';
import 'utils/seed_recipes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Örnek tarifleri Firestore'a ekle (sadece ilk çalıştırmada)
  //await SeedRecipes.seedRecipes();

  runApp(const TarifBurdaApp());
}

class TarifBurdaApp extends StatelessWidget {
  const TarifBurdaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TarifBurada',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2A6CB0),
          primary: const Color(0xFF2A6CB0),
          secondary: const Color(0xFFFF5722),
          tertiary: const Color(0xFF4CAF50),
          background: Colors.grey[50],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF2A6CB0),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF2A6CB0),
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
} 