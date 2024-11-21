import 'package:flutter/material.dart';
import 'package:tip_app/billSplitter.dart';

void main (){
  runApp(tipApp());
}

class tipApp extends StatelessWidget {
  const tipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App for tipping',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black
          )
        )
      ),home: BillSplitter(),
    );
  }
}
