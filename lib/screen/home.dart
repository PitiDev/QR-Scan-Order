import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_order/api/api.dart';
import 'package:qr_order/screen/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String table;

  @override
  void initState() {
    // TODO: implement initState
    gettable();
    super.initState();
  }

  void gettable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      table = prefs.getString('table');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ໂຕະ: ${table}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0XFFEF6E00),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            height: 550,
            child: Category(),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/image/profile.png',
                      width: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Order Food')
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Color(0XFFBEBEBE)),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text(
                'Setting',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: MaterialButton(
          color: Color(0XFFEF6E00),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () async {
            Navigator.pushNamed(context, '/cus-order');
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ລາຍການອາຫານທີ່ທ່ານສັ່ງແລ້ວ',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
