import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_tracking_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(FoodOrderingApp());
}

class FoodOrderingApp extends StatefulWidget {
  @override
  _FoodOrderingAppState createState() => _FoodOrderingAppState();
}

class _FoodOrderingAppState extends State<FoodOrderingApp> {
  List<Map<String, dynamic>> cart = []; // Shared cart instance

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Ordering App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      initialRoute: '/', // Start with Splash Screen
      routes: {
        '/': (context) => SplashScreen(), // Splash Screen as the first screen
        '/home': (context) => HomeScreen(),
        '/menu': (context) => MenuScreen(restaurantName: 'Default Restaurant', cart: cart),
        '/cart': (context) => CartScreen(cartItems: cart),
        '/order_tracking': (context) => OrderTrackingScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
