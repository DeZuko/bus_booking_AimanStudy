// ADD Booking Form
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mytest/widgets/constant_color.dart';
import 'package:mytest/widgets/constant_widget.dart';
import 'package:mytest/pages/authentication/shared_preferences.dart';
import 'package:mytest/models/bus_ticket.dart';
import 'package:mytest/models/station.dart';
import 'package:mytest/database/database_service.dart';
import 'package:mytest/database/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

class AddBooking extends StatefulWidget {
  final Station station;

  const AddBooking({Key? key, required this.station}) : super(key: key);

  @override
  State<AddBooking> createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  final _formKey = GlobalKey<FormState>();
  final departDateCon = TextEditingController();
  final departTimeCon = TextEditingController();

  String? station;

  DateTime? departDate;
  TimeOfDay? departTime;
  // Station? stationChoice;

  @override
  Widget build(BuildContext context) {
    Database db = Provider.of<DbProvider>(context).db;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.station.station,
        ),
      ),
      body: FutureBuilder(
          future: DatabaseServices(db: db).getAllStation(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Station> stations = snapshot.data;
              stations.removeWhere(
                  (element) => element.station == widget.station.station);
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            16 * 2, 16 * 2, 16 * 2, 16 * 2),
                        child: Column(
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                hint: const Text(
                                  'Departure Station',
                                  style: kwinputStyle,
                                ),
                                style: kwinputStyle,
                                buttonDecoration: BoxDecoration(
                                    color: kcWhite,
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                      color: kcBlack,
                                      width: 0.5,
                                    )),
                                buttonWidth: double.infinity,
                                buttonPadding:
                                    padOnlyR(l: 20, r: 5, b: 8, t: 8),
                                icon: Icon(
                                  Icons.expand_more,
                                  size: 35,
                                  color:
                                      station != null ? kcPrimary : Colors.grey,
                                ),
                                value: station,
                                items: stations
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        value: e.station,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              e.station,
                                              style: const TextStyle(
                                                  color: kcBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    station = value!;
                                  });
                                },
                              ),
                            ),
                            gaphr(h: 25),

                            TextFormField(
                              readOnly: true,
                              onTap: () async => pickDate(),
                              style: kwinputStyle,
                              controller: departDateCon,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () => pickDate(),
                                    icon: const Icon(Icons.date_range_rounded)),
                                labelText: "Departure Date",
                                labelStyle: kwlabelStyle,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your departure date.';
                                } else {
                                  return null;
                                }
                              },
                            ),

                            //Spacing
                            gaphr(h: 25),

                            TextFormField(
                              readOnly: true,
                              onTap: () async => pickTime(),
                              style: kwinputStyle,
                              controller: departTimeCon,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () => pickTime(),
                                    icon: const Icon(Icons.av_timer_rounded)),
                                labelText: "Departure Time",
                                labelStyle: kwlabelStyle,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your departure time';
                                } else {
                                  return null;
                                }
                              },
                            ),

                            //Spacing
                            gaphr(h: 25),

                            // Spacing
                            const SizedBox(height: 16 * 2),
                            MaterialButton(
                              padding: kwInset0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              onPressed: () async {
                                //todo booking
                                if (_formKey.currentState!.validate() &&
                                    station != null) {
                                  DateTime depart = DateTime(
                                      departDate!.year,
                                      departDate!.month,
                                      departDate!.day,
                                      departTime!.hour,
                                      departTime!.minute);
                                  BusTicket busTicket = BusTicket(
                                    departDate: depart,
                                    time: depart,
                                    departStation: station!,
                                    destStation: widget.station.station,
                                    userId: Spreferences.getCurrentUserId()!,
                                  );

                                  int result = await DatabaseServices(db: db)
                                      .createBooking(busTicket);
                                  print(result);
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Booking Successful to ${widget.station.station}')),
                                  );
                                  // Navigator.of(context).pop();
                                } else {
                                  // if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please fill in the required field')),
                                  );
                                }
                              },
                              child: Ink(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 149, 87, 15),
                                    Color.fromARGB(255, 248, 205, 107),
                                  ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80.0)),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 88.0,
                                      minHeight:
                                          36.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'OK',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }

  void pickDate() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        departDate = date;
        departDateCon.text = DateFormat("dd MMMM, yyyy").format(departDate!);
      });
    });
  }

  void pickTime() async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        departTime = time;
        departTimeCon.text = DateFormat("h:mm a").format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            time.hour,
            time.minute));
      });
    });
  }
}
