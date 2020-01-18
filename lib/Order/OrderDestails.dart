import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Card/OrderCard.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class OrderDetails extends StatefulWidget {
  final gmail;

  OrderDetails({this.gmail});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    // TODO: implement initState

    //  load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(Common.order)
                    .child(widget.gmail)
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.data == null ||
                      snapshot.data.snapshot.value == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    List<String> list_price = new List();
                    List<String> list_catagory_id = new List();
                    List<String> list_child = new List();
                    List<String> list_discription = new List();
                    List<String> list_image = new List();
                    List<String> list_name = new List();
                    List<String> list_quantity = new List();
                    List<String> list_rating = new List();

                    Map<dynamic, dynamic> _data = snapshot.data.snapshot.value;

                    _data.forEach((k, v) {
                      list_price.add(v["buy_price"]);
                      list_catagory_id.add(v["catagory_id"]);
                      list_child.add(v["child"]);
                      list_discription.add(v["discription"]);
                      list_image.add(v["image"]);
                      list_name.add(v["name"]);
                      list_quantity.add(v["quantiry"].toString());
                      list_rating.add(v["rating"]);
                    });

                    return ListView.builder(
                        itemCount: list_price.length,
                        itemBuilder: (context, int index) {
                          return OrderCard(
                            image: list_image[index],
                            address: list_price[index],

                            /// order details price
                            number: list_catagory_id,
                            name: list_name[index],
                            order_qunatity: "Quantity ${list_quantity[index]}",
                            //k: _key[index],
                            // gmail: [index],
                          );
                        });
                  }
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1)
              ]),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Confirm Order",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 2,
                                blurRadius: 2)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Text("Confirm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold))),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
