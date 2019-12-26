import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child(Common.order)
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.data == null ||
                    snapshot.data.snapshot.value == null) {
                  return Container();
                } else {
                  Map<dynamic, dynamic> _order_list =
                      snapshot.data.snapshot.value;

                  List<String> _user_name = new List();
                  List<String> _user_image = new List();
                  List<String> _user_address = new List();
                  List<String> _user_email = new List();
                  List<String> _user_number = new List();

                  List<String> total_order_product = new List();

                  List<String> total_amount = new List();

                  _order_list.forEach((k, v) {
                    print("kllllllllllllllll  ${k}");

                    print("Valuseeeee  ${v}");

                    FirebaseDatabase.instance
                        .reference()
                        .child(Common.user)
                        .child(k)
                        .child(Common.basic_info)
                        .once()
                        .then((user) {
                      print("Useeeeeeeeeeerr ${user.value["name"]}");

                      _user_name.add(user.value["name"]);
                      _user_email.add(user.value["email"]);
                      _user_image.add(user.value["Image"]);
                      _user_number.add(user.value["phone"]);
                      _user_address.add(user.value["Address"]);
                    });
                  });

                  return ListView.builder(
                      itemCount: _user_address.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(_user_image[index])),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[],
                              ),
                            ],
                          ),
                        );
                      });
                }
              })),
    );
  }
}
