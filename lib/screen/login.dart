import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ScanResult scanResult;

  final _flashOnController = TextEditingController(text: "ເປີດ Flash");
  final _flashOffController = TextEditingController(text: "ປິດ Flash");
  final _cancelController = TextEditingController(text: "ຍົກເລີກ");
  String txtcode;

  TextEditingController table = new TextEditingController();

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //print('== Table  == ${prefs.getString('table')}');
        scanResult = result;
        txtcode = scanResult.rawContent;
        table.text = scanResult.rawContent;
        prefs.setString('table', table.text);
        print('==== Barcode === ${scanResult.rawContent}');
      });
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      setState(() {
        print('==== Barcode === ${scanResult}');
        scanResult = result;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('==== click ${table.text}');
    if (table.text != '') {
      prefs.setString('table', table.text);
      Navigator.pushNamed(context, '/adduser');
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/image/logo.png',
                width: 200,
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      scan();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Image.network(
                        'https://static.thenounproject.com/png/78107-200.png',
                        width: 100,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0XFFF8F8F8),
                    ),
                    child: TextField(
                      controller: table,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        hintText: 'ເບີໂຕະ',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
                      ),
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 60, left: 20, right: 20),
                    child: MaterialButton(
                      minWidth: 318,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Color(0XFFEF6E00),
                      child: Container(
                        padding: EdgeInsets.all(14),
                        child: Text(
                          'ເຂົ້າສູ່ເມນູ',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        login();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
