import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Card/OrderCard.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<String> _user_gmail = new List();

  List<String> _order_quantity = new List();

  //User info

  List<String> _user_name = new List();
  List<String> _user_address = new List();
  List<String> _user_image = new List();
  List<String> _user_number = new List();
  List<String> _key=new List();


  var load_complete = false;

  @override
  void initState() {
    // TODO: implement initState

    load();

    super.initState();
  }

  void load() async {
    FirebaseDatabase.instance.reference().child(Common.order).once().then((v) {
      Map<dynamic, dynamic> _order = v.value;

      _order.forEach((k, v) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.user)
            .child(k)
            .child(Common.basic_info)
            .once()
            .then((user) {
          // _user_gmail.add(user.value["email"]);


          print("Keyyyyyyyyyyyyyyyyyyyyyyyyy... ${k}");
          print("Valueeeeeeeeeeeeeeeeeeeeeee... ${v}");




          Map<dynamic,dynamic> key= v;

          key.forEach((k,v){



            _key.add(k);


          });



          _user_address.add(user.value["Address"]);
          _user_number.add(user.value["phone"]);
          _user_name.add(user.value["name"]);
          _user_image.add(user.value["Image"]);

          _user_gmail.add(k);

          _order_quantity.add(v.length.toString());

          print(user.value["Address"]);
          print(user.value["phone"]);
          print(user.value["name"]);
          print(user.value["Image"]);

          print(k);


          print("finiseddddddddddd  ");

          setState(() {

            load_complete=true;

          });

        });





      });



    });



  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: load_complete ? ListView.builder(
            itemCount: _user_name.length,
            itemBuilder: (context, int index) {
              return  OrderCard(
                image: _user_image[index],
                address: _user_address[index],
                number: _user_number[index],
                name: _user_name[index],
                order_qunatity: "Order ${_order_quantity[index]}",
                k: _key[index],
                gmail: _user_gmail[index],
              );
            }):Container(),

      )),
    );
  }
}
