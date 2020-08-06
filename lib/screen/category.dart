import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_order/api/api.dart';
import 'package:qr_order/screen/menufood.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List _dataCategory = new List();

  void getCategory() async {
    final res = await ApiApp().getURL('list-category');
    final body = json.decode(res.body);
    print('==== ${body}');
    setState(() {
      _dataCategory = body as List;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dataCategory.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: _dataCategory.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('category_id', _dataCategory[index]['id'].toString());
                  Navigator.pushNamed(context, '/menufood');
//                  Navigator.of(context).push(new MaterialPageRoute(
//                    builder: (context) => new Menufood(
//                      id: _dataCategory[index]['id'],
//                    ),
//                  ));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      constraints: BoxConstraints.expand(height: 200),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              image: NetworkImage('http://192.168.43.37/food_api/public/${_dataCategory[index]['image']}'), fit: BoxFit.cover)),
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10, top: 5),
                                        child: Text(
                                          '${_dataCategory[index]['name']}',
                                          style: TextStyle(color: Colors.white, fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
