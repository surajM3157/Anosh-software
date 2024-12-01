import 'package:demo_project_anosh_software/screens/invoice_desktop_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/invoice_preview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice Desktop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MyInvoicePage(),
    );
  }
}
