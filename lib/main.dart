import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fractional_realestate_investing/screens/mobile/home_screen.dart';
import 'package:fractional_realestate_investing/screens/mobile/property_detail_screen.dart';
import 'screens/Web/admin_panel.dart';
import 'screens/mobile/login_screen.dart';
import 'screens/mobile/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is initialized only once
  if (Firebase.apps.isEmpty) {
    print('Initializing Firebase...');
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBxgccf7Kf6fukUh4rXQ04796ynA5Y5v_A",
        authDomain: "fractional-realestate-invest.firebaseapp.com",
        databaseURL: "https://fractional-realestate-invest-default-rtdb.firebaseio.com",
        projectId: "fractional-realestate-invest",
        storageBucket: "fractional-realestate-invest.appspot.com",
        messagingSenderId: "619278053496",
        appId: "1:619278053496:web:f896d461159095a3c9bd8d",
        measurementId: "G-HSPTY8FXNC",
      ),
    );
  } else {
    print('Firebase already initialized.');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fractional Real Estate Investing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => RealEstateScreen(),
        '/property-details': (context) => const PropertyDetailScreen(),
        '/login': (context) => LoginScreen(),
        '/admin': (context) => AdminPanel(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}
