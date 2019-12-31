import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Order/Order.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class NavigationDrawer extends StatelessWidget {
  // final key;

  Function closeDrawer;

  Function fun_home;
  Function fun_chart;
  Function fun_order;
  Function fun_profile;

  //Function fun_profile;
  Function fun_fav;

  Function fun_all_product;

  //Function fun_profile;

  NavigationDrawer(
      {Key key,
      this.closeDrawer,
      this.fun_fav,
      this.fun_home,
      this.fun_profile,
      this.fun_chart,
      this.fun_all_product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          width: MediaQuery.of(context).size.width / 1.8,
          height: MediaQuery.of(context).size.height,
          child: Center(
            // alignment: Alignment.centerRight,

            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
/*
              crossAxisAlignment: CrossAxisAlignment.center,

              mainAxisAlignment: MainAxisAlignment.values[5],*/
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Image(
                    image: AssetImage(
                      "Img/superfresh.png",
                    ),
                    width: 100,
                    height: 100,
                  )),
                  SizedBox(
                    height: 35,
                  ),
                  InkWell(
                    onTap: () {
                      //new HomePlate(current_state: "profile",);

                      // Navigator.of(context).pop();
                      closeDrawer();

                      Navigator.of(context).push(
                          new MaterialPageRoute(builder: (context) => Order()));

                      // fun_home();

                      // print("Homeeeee");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.reorder),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Order",
                            style: TextStyle(
                                color: Common.orange_color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 15,
            right: 15,
            child: InkWell(
                onTap: () {
                  // this.

                  closeDrawer();
                },
                child: Icon(
                  Icons.close,
                  color: Common.orange_color,
                )))
      ],
    ));
  }
}
