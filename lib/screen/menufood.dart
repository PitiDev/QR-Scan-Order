import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_order/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");

class Menufood extends StatefulWidget {
  @override
  _MenufoodState createState() => _MenufoodState();
}

class _MenufoodState extends State<Menufood> {
  List _dataMenu = new List();
  int _NumberOrder = 0;
  String Count;

  void getMenu() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {
      "id": "${prefs.getString('category_id')}",
    };
    final res = await ApiApp().postURL(data, 'get-menu');
    final body = json.decode(res.body);
    print('== Menu == ${body}');
    setState(() {
      _dataMenu = body as List;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMenu();
    setCart();
    super.initState();
  }

  void setCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Count = prefs.getString('count');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ເມນູອາຫານ'),
        backgroundColor: Color(0XFFEF6E00),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: new Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/order');
                  },
                ),
                new Positioned(
                  top: 1.0,
                  right: 1.0,
                  child: new Center(
                    child: Count == null
                        ? Container()
                        : new Text(
                            '${Count}',
                            style: new TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w500),
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            height: 600,
            child: _dataMenu.isEmpty
                ? Container()
                : ListView.builder(
                    itemCount: _dataMenu.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage('http://127.0.0.1/food_api/public/${_dataMenu[index]['image']}'),
                            ),
                            title: Text(
                              '${_dataMenu[index]['name']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('ລາຄາ: ${formatter.format(int.parse(_dataMenu[index]['price']))} Kip'),
                            trailing: Column(
                              children: <Widget>[
                                MaterialButton(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                  onPressed: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    var data = {
                                      "table": "${prefs.getString('table')}",
                                      "menu": _dataMenu[index]['id'].toString(),
                                      "status": '0',
                                    };
                                    final res = await ApiApp().postURL(data, 'add-order');
                                    final body = json.decode(res.body);
                                    print('== Add ${body} ');
                                    setState(() async {
                                      _NumberOrder++;
                                      prefs.setString('count', _NumberOrder.toString());
                                      setCart();
                                    });
                                  },
                                  color: Color(0XFFE86600),
                                  child: Text(
                                    'Add',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: MaterialButton(
          color: Color(0XFFEF6E00),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () async {
            Navigator.pushNamed(context, '/order');
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
                  'ລາຍການສັ່ງອາຫານ',
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
