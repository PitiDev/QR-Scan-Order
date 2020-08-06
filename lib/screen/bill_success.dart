import 'package:flutter/material.dart';
import 'package:smart_flare/actors/smart_flare_actor.dart';

class BillSuccess extends StatefulWidget {
  @override
  _BillSuccessState createState() => _BillSuccessState();
}

class _BillSuccessState extends State<BillSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Check Bill Success',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Center(
            child: Text(
              'ກະລຸນາລໍຖ້າພະນັກງານຮັບເງີນ',
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
                  Icons.check_box,
                  color: Colors.white,
                ),
                Text(
                  'ສັ່ງອາຫານອິກຄັ້ງ',
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
