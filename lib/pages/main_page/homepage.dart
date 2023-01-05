import 'package:mytest/authentication/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mytest/forms/add_booking_form.dart';
import 'package:mytest/pages/main_page/booking_cart.dart';

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
    "Please Book Your Ticket",
    "Your Booking",
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
              // Set the session validation = false
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
            color: Color.fromARGB(160, 255, 255, 255),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 61, 54, 158),
      ),

      // Cards
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          // Booking Form
          AddBooking(),
          // Booking Cart
          BookingCart(),
        ],
      ),

      // Bottom Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 61, 54, 158),
        onTap: _onItemTapped,
      ),
    );
  }
}
