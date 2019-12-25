import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Display/Banner/Banner.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: Icon(
          Icons.menu,
          color: Colors.black45,
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
        onPressed: () {},
        child: Text("Catagory",
            style: TextStyle(
                color: Common.orange_color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  _favourite() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        onPressed: () {},
        child: Text("Favourite",
            style: TextStyle(
                color: Common.orange_color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
