// Cart main page
import 'package:flutter/material.dart';
import 'package:mytest/widgets/constant_widget.dart';
import 'package:mytest/models/bus_ticket.dart';
import 'package:mytest/database/database_service.dart';
import 'package:mytest/database/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class BookingCart extends StatefulWidget {
  const BookingCart({Key? key}) : super(key: key);

  @override
  State<BookingCart> createState() => _BookingCartState();
}

class _BookingCartState extends State<BookingCart> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Database db = Provider.of<DbProvider>(context).db;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
          future: DatabaseServices(db: db).getAllBooking(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print('here');
              List<BusTicket> bookings = snapshot.data;
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {});
                },
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16 * 2, 16, 16 * 2),
                  child: ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                        ),
                      ),
                      color: Colors.white70,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: ListTile(
                        title: Text(
                          bookings[index].destStation,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          dateformatNumSlashI(bookings[index].departDate),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/EditBooking',
                                          arguments: bookings[index])
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Delete Booking Confirmation"),
                                        content: Text(
                                            "Are you sure you want to delete booking to ${bookings[index].destStation}?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              if (!mounted) return;
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await DatabaseServices(db: db)
                                                  .deleteBooking(
                                                      bookings[index].id!);
                                              if (!mounted) return;
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
              );
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400.withOpacity(0.7),
                ),
                child: const CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }
}
