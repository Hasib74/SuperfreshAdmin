import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Display/Banner/Banner.dart';
import 'package:super_fresh_admin/Display/Category/Category.dart';
import 'package:super_fresh_admin/Display/Popular/Popular.dart';
import 'package:super_fresh_admin/Display/Product/Product.dart';
import 'package:super_fresh_admin/Drawer/NaviationDrawer.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DisplayHome(),
    );
  }
}

class DisplayHome extends StatefulWidget {
  @override
  _DisplayHomeState createState() => _DisplayHomeState();
}

class _DisplayHomeState extends State<DisplayHome> {
  GlobalKey<ScaffoldState> _key = new GlobalKey();

  close_drawer() {
    _key.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: NavigationDrawer(
        closeDrawer: close_drawer,
      ),
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: new Text(
          "Home",
          style:
              TextStyle(color: Color(0xffFF4518), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            _key.currentState.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: Colors.black45,
          ),
        ),
        actions: <Widget>[
          Icon(
            Icons.notifications,
            color: Colors.black45,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          _banner(),
          _catagory(),
          _favourite(),
          _product(),
        ],
      ),
    );
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => DisplayBanner()));
        },
        child: Text(
          "Banner",
          style: TextStyle(
              color: Common.orange_color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  _catagory() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => Category()));
        },
        child: Text("Category",
            style: TextStyle(
                color: Common.orange_color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  _favourite() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => Popular()));
        },
        child: Text("Popular",
            style: TextStyle(
                color: Common.orange_color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  _product() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => AllProducts()));
        },
        child: Text("Product",
            style: TextStyle(
                color: Common.orange_color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
