import 'package:flutter/material.dart';
import 'package:mytest/widgets/constant_color.dart';
import 'package:mytest/widgets/constant_widget.dart';
import 'package:mytest/authentication/shared_preferences.dart';
import 'package:mytest/models/user.dart';
import 'package:mytest/database/database_service.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mytest/database/database_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Database db = Provider.of<DbProvider>(context).db;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
          future: DatabaseServices(db: db)
              .getUser(Spreferences.getCurrentUserId()!),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(16 * 2),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 16 * 2),
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/avatar.png"),
                        radius: 100,
                      ),
                      const SizedBox(height: 16 * 2),
                      const Text('Username'),
                      Text(
                        user.username,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: kfbold,
                        ),
                      ),
                      gaphr(),
                      const Text('Name'),
                      Text(
                        '${user.fName} ${user.lName}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gaphr(),
                      const Text('Phone Number'),
                      Text(
                        user.mobileHp,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gaphr(),
                      const SizedBox(height: 16 * 2),
                      const SizedBox(height: 16 * 2),
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

  Row rowInfo(IconData icon, String data) {
    return Row(
      children: [
        Icon(
          icon,
          color: kcPrimary,
          size: 30,
        ),
        gapwr(w: 25),
        Text(
          data,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
