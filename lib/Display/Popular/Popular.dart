import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Display/Category/AddCategory.dart';
import 'package:super_fresh_admin/Display/Popular/AddPopular.dart';
import 'package:super_fresh_admin/Model/Category.dart';
import 'package:super_fresh_admin/Model/MPopular.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Popular",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Common.orange_color),
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black45,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                  onTap: () {
                    /* setState(() {
                      page = "addbanner";
                    });*/

                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AddPopular()));
                  },
                  child: new Icon(
                    Icons.add,
                    color: Colors.black45,
                  )),
            )
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseDatabase.instance
                .reference()
                .child(Common.popular)
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.data == null ||
                  snapshot.data.snapshot.value == null) {
                return Container();
              } else {
                List<MPopular> _category_list = new List();

                //   _temp_category_list.clear();

                Map<dynamic, dynamic> _category = snapshot.data.snapshot.value;

                _category.forEach((k, v) {
                  _category_list.add(new MPopular(
                      name: v["name"],
                      image: v["image"],
                      id: k,
                      previous_price: v["previous_price"],
                      price: v["price"],
                      discount: v["discount"],
                      description: v["description"],
                      categoryId: v["categoryId"]));
                });

                return ListView.builder(
                    itemCount: _category_list.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 130,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            _category_list[index].image)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 2,
                                          spreadRadius: 2)
                                    ]),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 20,
                                    color: Colors.black38,
                                    child: Center(
                                      child: Text(
                                        "${_category_list[index].name}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      // print("Valueeeeeeeeeeeeeeeeeeeee  ${value}");

                                      _popUpMenuAction(
                                          value, _category_list[index]);
                                    },
                                    itemBuilder: (context) {
                                      return <PopupMenuEntry<String>>[
                                        const PopupMenuItem(
                                            value: "Update",
                                            child: ListTile(
                                              leading: Icon(Icons.edit),
                                              title: Text("Update"),
                                            )),
                                        const PopupMenuItem(
                                            value: "Delete",
                                            child: ListTile(
                                              leading: Icon(Icons.delete),
                                              title: Text("Delete"),
                                            )),
                                      ];
                                    },
                                    child: new Icon(
                                      Icons.more_vert,
                                      color: Common.orange_color,
                                    )),
                              )
                            ],
                          ));
                    });
              }
            }),
      ),
    );
  }

  void _popUpMenuAction(String value, MPopular mCategory) {
    if (value == "Delete") {
      FirebaseDatabase.instance
          .reference()
          .child(Common.popular)
          .child(mCategory.id)
          .remove()
          .then((_) {
        print("Remove successfully");

        //_load();
      });
    } else if (value == "Update") {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => AddPopular(
                popular: mCategory,
              )));

      /*setState(() {

        _update_banner =mBanner;

        page = "Update";
      });*/
    }
  }
}
