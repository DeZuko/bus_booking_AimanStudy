// UPDATE Booking Form
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
import 'package:sqflite/sqflite.dart';

class EditBooking extends StatefulWidget {
  final BusTicket busTicket;
  const EditBooking({
    Key? key,
    required this.busTicket,
  }) : super(key: key);

  @override
  State<EditBooking> createState() => _EditBookingState();
}

class _EditBookingState extends State<EditBooking> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController departDateCon = TextEditingController();
  TextEditingController departTimeCon = TextEditingController();

  DateTime? departDate;
  TimeOfDay? departTime;
  Station? stationChoice;
  String? departStation, destStation;

  @override
  void initState() {
    super.initState();
    departDateCon = TextEditingController(
      text: DateFormat("dd MMMM, yyyy").format(widget.busTicket.departDate),
    );
    departTimeCon = TextEditingController(
      text: DateFormat("h:mm a").format(widget.busTicket.time),
    );
    departStation = widget.busTicket.departStation;
    destStation = widget.busTicket.destStation;
    departDate = widget.busTicket.departDate;
    departTime = TimeOfDay(
        hour: widget.busTicket.time.hour, minute: widget.busTicket.time.minute);
  }

  @override
  Widget build(BuildContext context) {
    Database db = Provider.of<DbProvider>(context).db;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit My Booking'),
        backgroundColor: Colors.deepPurple.shade800,
      ),
      body: FutureBuilder(
          future: DatabaseServices(db: db).getAllStation(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Station> stations = snapshot.data;
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
                                  color: departStation != null
                                      ? kcPrimary
                                      : Colors.grey,
                                ),
                                value: departStation,
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
                                    departStation = value!;
                                  });
                                },
                              ),
                            ),
                            gaphr(h: 25),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                hint: const Text(
                                  'Destination Station',
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
                                  color: departStation != null
                                      ? kcPrimary
                                      : Colors.grey,
                                ),
                                value: destStation,
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
                                    destStation = value!;
                                  });
                                },
                              ),
                            ),
                            gaphr(h: 30),

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
                            gaphr(h: 30),

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
                                //todo edit booking
                                if (_formKey.currentState!.validate() &&
                                    departStation != null &&
                                    destStation != null) {
                                  DateTime depart = DateTime(
                                      departDate!.year,
                                      departDate!.month,
                                      departDate!.day,
                                      departTime!.hour,
                                      departTime!.minute);
                                  BusTicket busTicket = BusTicket(
                                    id: widget.busTicket.id,
                                    departDate: depart,
                                    time: depart,
                                    departStation: departStation!,
                                    destStation: destStation!,
                                    userId: Spreferences.getCurrentUserId()!,
                                  );

                                  int result = await DatabaseServices(db: db)
                                      .updateBooking(busTicket);
                                  print(result);
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Edit Booking Successful to $destStation')),
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  if (!mounted) return;
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
                                    Color.fromARGB(255, 163, 94, 180),
                                    Color.fromARGB(255, 108, 42, 117),
                                  ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80.0)),
                                ),
                                child: Container(
                                  width: 140,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Update',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
