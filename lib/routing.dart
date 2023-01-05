import 'package:flutter/cupertino.dart';
import 'package:mytest/models/bus_ticket.dart';
// import 'package:mytest/models/station.dart';
import 'package:mytest/forms/add_booking_form.dart';
import 'package:mytest/forms/edit_booking_form.dart';
import 'package:mytest/pages/first_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // Called during the first open
      case '/':
        return CupertinoPageRoute(builder: (_) => const FirstPage());
      // Called when updating cart
      case '/EditBooking':
        return CupertinoPageRoute(
            builder: (_) => EditBooking(busTicket: args as BusTicket));
      // case '/AddBooking':
      //   return CupertinoPageRoute(builder: (_) => const AddBooking());
      default:
        return CupertinoPageRoute(builder: (_) => const FirstPage());
    }
  }
}
