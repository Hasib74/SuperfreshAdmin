import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Display/Category/AddCategory.dart';
import 'package:super_fresh_admin/Model/Category.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Category",
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
                        builder: (context) => AddCategory()));
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
                .child(Common.category)
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.data.snapshot.value == null ||
                  snapshot.data == null) {
                return Container();
              } else {
                List<MCategory> _category_list = new List();

                //   _temp_category_list.clear();

                Map<dynamic, dynamic> _category = snapshot.data.snapshot.value;

                _category.forEach((k, v) {
                  _category_list.add(
                      new MCategory(name: v["name"], image: v["image"], id: k));
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

  void _popUpMenuAction(String value, MCategory mCategory) {
    if (value == "Delete") {
      FirebaseDatabase.instance
          .reference()
          .child(Common.category)
          .child(mCategory.id)
          .remove()
          .then((_) {
        print("Remove successfully");

        //_load();
      });
    } else if (value == "Update") {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => AddCategory(
                update_category: mCategory,
              )));

      /*setState(() {

        _update_banner =mBanner;

        page = "Update";
      });*/
    }
  }
}
