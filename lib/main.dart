import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytest/widgets/constant_color.dart';
import 'package:mytest/authentication/shared_preferences.dart';
import 'package:mytest/database/database_init.dart';
import 'package:mytest/database/database_provider.dart';
import 'package:mytest/routing.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database db = await DbInit.connect();
  await Spreferences.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DbProvider>.value(value: DbProvider(db: db)),
    //Provider.value(value: db)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: kcPrimarySwatch,
            ),
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
