import 'package:mytest/pages/authentication/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mytest/pages/main_page/booking_cart.dart';
import 'package:mytest/pages/main_page/profile_page.dart';
import 'package:mytest/pages/main_page/booking_main.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<String> cards = [
    "Station",
    "Booking",
    // "Profile",
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Set session validation = false
              await Spreferences.setIsLogin(false);
              await Spreferences.setCurrentUserId(0);
              if (!mounted) return;
              Navigator.of(context).pushReplacementNamed("/");
            },
          )
        ],
        centerTitle: true,
        title: Text(
          cards[_selectedIndex],
          style: const TextStyle(
            color: Color.fromARGB(162, 73, 44, 10),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 147, 94, 50),
      ),

      // Cards
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          BookingMain(),
          BookingCart(),
          // ProfilePage(),
        ],
      ),

      // Bottom Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Cart',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   label: 'Profile',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 232, 172, 93),
        onTap: _onItemTapped,
      ),
    );
  }
}
