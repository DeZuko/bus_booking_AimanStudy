import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytest/widgets/constant_color.dart';
import 'package:mytest/widgets/constant_widget.dart';
import 'package:mytest/models/station.dart';
import 'package:mytest/database/database_service.dart';
import 'package:mytest/database/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class BookingMain extends StatefulWidget {
  const BookingMain({Key? key}) : super(key: key);

  @override
  State<BookingMain> createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain> {
  @override
  Widget build(BuildContext context) {
    Database db = Provider.of<DbProvider>(context).db;
    // Work as whitespace
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
        future: DatabaseServices(db: db).getAllStation(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Station> stations = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              shrinkWrap: true,
              itemCount: stations.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16 * 2, vertical: 10),
                  child: Column(
                    children: [
                      Material(
                        elevation: 5,
                        shape: cornerR(r: 10),
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: borderRadiuscR(r: 11),
                          child: MaterialButton(
                            padding: kwInset0,
                            color: kcWhite,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/AddBooking');
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  // Display stations as header
                                  child: Text(
                                    stations[index].station,
                                  ),
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    height: 150,
                                    child: Image.asset(
                                      stations[index].imageURL,
                                      fit: BoxFit.cover,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      gaphr(h: 10)
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
