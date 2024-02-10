
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpr/routes/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env["url"]!,
    anonKey: dotenv.env["anonKey"]!
  );

  runApp(GetMaterialApp(
    theme: ThemeData(
      appBarTheme: const AppBarTheme(
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)
          )
      ),
    ),
    home: const Home(),
  ));
}
