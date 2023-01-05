import 'package:flutter/cupertino.dart';
import 'package:mytest/models/bus_ticket.dart';
// import 'package:mytest/models/station.dart';
import 'package:mytest/pages/forms/add_booking_form.dart';
import 'package:mytest/pages/forms/edit_booking_form.dart';
import 'package:mytest/pages/first_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => const FirstPage());
      case '/AddBooking':
        return CupertinoPageRoute(builder: (_) => const AddBooking());
      case '/EditBooking':
        return CupertinoPageRoute(
            builder: (_) => EditBooking(busTicket: args as BusTicket));
      default:
        return CupertinoPageRoute(builder: (_) => const FirstPage());
    }
  }
}
