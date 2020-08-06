import 'package:flutter/material.dart';
import 'package:qr_order/screen/bill_success.dart';
import 'package:qr_order/screen/cus_order.dart';
import 'package:qr_order/screen/home.dart';
import 'package:qr_order/screen/login.dart';
import 'package:qr_order/screen/menufood.dart';
import 'package:qr_order/screen/order.dart';
import 'package:qr_order/screen/success.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'lao'),
        home: Login(),
        routes: <String, WidgetBuilder>{
          '/login': (_) => Login(),
          '/home': (_) => Home(),
          '/menufood': (_) => Menufood(),
          '/order': (_) => Order(),
          '/Success': (_) => Success(),
          '/cus-order': (_) => CusOrder(),
          '/bill-success': (_) => BillSuccess()
        });
  }
}
