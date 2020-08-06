import 'package:flutter/material.dart';
import 'package:smart_flare/actors/smart_flare_actor.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        elevation: 0,
//        title: Text(
//          'ສໍາເລັດ',
//          style: TextStyle(color: Colors.white),
//        ),
//        backgroundColor: Color(0XFFEF6E00),
//      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Center(
            child: SmartFlareActor(width: 295.0, height: 251.0, filename: 'assets/image/Check.flr', startingAnimation: 'animate'),
          ),
          Center(
            child: Text(
              'ສັ່ງອາຫານສໍາເລັດແລ້ວ',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Center(
            child: Text(
              'ກະລຸນາລໍຖ້າ Order',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: MaterialButton(
          color: Color(0XFFEF6E00),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () async {
            Navigator.pushNamed(context, '/home');
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                Text(
                  'ກັບໄປໜ້າຫຼັກ',
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
