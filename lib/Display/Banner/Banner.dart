import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Display/Banner/AddBanner.dart';
import 'package:super_fresh_admin/Model/Banner.dart';
import 'package:super_fresh_admin/Model/Comments.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class DisplayBanner extends StatefulWidget {
  final banner;

  DisplayBanner({this.banner});

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<DisplayBanner> {
  List<MBanner> _final_banner_list = new List();

  MBanner _update_banner;

  var page = "banner";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _load();
  }

  _load() {
    _getBanner();

    _getBanner().then((v) {
      setState(() {
        _final_banner_list = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return page == "banner"
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                "Banner",
                style: TextStyle(color: Common.orange_color),
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
                        setState(() {
                          page = "addbanner";
                        });
                      },
                      child: new Icon(
                        Icons.add,
                        color: Colors.black45,
                      )),
                )
              ],
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: _final_banner_list.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(

                          //  color: Colors.transparent,

                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, spreadRadius: 2)
                          ],
                          image: DecorationImage(

                              /* colorFilter: new ColorFilter.mode(
                                  Colors.orange.withOpacity(0.8), BlendMode.dstATop),*/
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  _final_banner_list[index].image))),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black12,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        _final_banner_list[index].discount,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Offer",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Big Offers",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "For Limited Time",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  new Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFF5126),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Order Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
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
                                      value, _final_banner_list[index]);
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
                      ),
                    ),
                  );
                }),
          )
        : AddBanner(
            banner: _update_banner,
          );
  }

  Future<List<MBanner>> _getBanner() async {
    List<MBanner> _banner_list = new List();

    await FirebaseDatabase.instance
        .reference()
        .child(Common.banner)
        .once()
        .then((banner) {
      List<Comments> _comments_list = new List();

      print("BBBBBBBBBBBBBBBBBBBB  ${banner.value}");

      Map<dynamic, dynamic> _banner = banner.value;

      _banner.forEach((k, v) {
        print("Vallllllllllllllllllllllllllllllluuu  ${v["name"]}");

        _banner_list.add(new MBanner(
            comments_list: _comments_list,
            rating: v["rating"],
            name: v["name"],
            image: v["image"],
            id: k,
            price: v["price"],
            description: v["description"],
            discount: v["discount"],
            previous_price: v["previous_price"]));

        if (v["Comments"] != null) {
          Map<dynamic, dynamic> _comments = v["Comments"];

          _comments.forEach((k, v) {
            _comments_list.add(new Comments(
                name: v["name"],
                gmail: v["gmail"],
                image: v["image"],
                comments: v["comments"],
                rating: v["rating"]));
          });
        }
      });
    }).catchError((err) => print(err));

    return _banner_list;
  }

  void _popUpMenuAction(String value, MBanner mBanner) {
    if (value == "Delete") {
      FirebaseDatabase.instance
          .reference()
          .child(Common.banner)
          .child(mBanner.id)
          .remove()
          .then((_) {
        print("Remove successfully");

        _load();
      });
    } else if (value == "Update") {
      setState(() {
        _update_banner = mBanner;

        page = "Update";
      });
    }
  }

  changePage() {
    setState(() {
      page = "banner";

      _load();
    });
  }
}
