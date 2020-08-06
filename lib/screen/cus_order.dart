import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_order/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");

class CusOrder extends StatefulWidget {
  @override
  _CusOrderState createState() => _CusOrderState();
}

class _CusOrderState extends State<CusOrder> {
  List _dataOrder = new List();
  int total;
  String amount;
  String table;
  int _NumberOrder = 0;

  @override
  void initState() {
    // TODO: implement initState
    getOrder();
    gettable();
    super.initState();
  }

  void getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {
      "table": "${prefs.getString('table')}",
    };
    print('==tabel == ${prefs.getString('table')}');
    final res = await ApiApp().postURL(data, 'cus-order');
    final body = json.decode(res.body);
    print('== Order == ${body['data']}');
    print('== Total == ${body['total'][0]['total']}');
    print('== Amount == ${body['amount']}');
    var totalamount = body['amount'];
    setState(() {
      _dataOrder = body['data'] as List;
      total = body['total'][0]['total'];
      amount = totalamount;
    });
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
        title: Text('ລາຍການອາຫານທີ່ທ່ານສັ່ງແລ້ວ'),
        backgroundColor: Color(0XFFEF6E00),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'ລາຍການສັ່ງອາຫານ',
              style: TextStyle(fontSize: 17),
            ),
          ),
          Container(
            height: 400,
            child: _dataOrder.isEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Text(
                      'ທ່ານຍັງບໍ່ມີລາຍການສັ່ງອາຫານ',
                      style: TextStyle(fontSize: 17, color: Colors.redAccent),
                    ),
                  )
                : ListView.builder(
                    itemCount: _dataOrder.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage('assets/image/res.jpg'),
                            ),
                            title: Text(
                              '${_dataOrder[index]['name']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('ລາຄາ: ${formatter.format(int.parse(_dataOrder[index]['price']))} Kip'),
                            trailing: Text(
                              'ຈໍານວນ: ${_dataOrder[index]['qty'] + _NumberOrder}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    }),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, top: 30),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ຈໍານວນທັງໝົດ: ${total} ລາຍການ',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ລວມລາຄາທີ່ຕ້ອງຈ່າຍ: ${amount} Kip',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ໂຕະ: ${table} ',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: MaterialButton(
          color: Color(0XFFEF6E00),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('count');
            var data = {
              "table": prefs.getString('table'),
              "status": "1",
            };
            final res = await ApiApp().postURL(data, 'check-bill');
            final body = json.decode(res.body);

            print(' === Status == ${body['status']}');
            if (body['status'] == 'success') {
              Navigator.pushNamed(context, '/bill-success');
            }
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
                  'Check Bill',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
