import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  close_drawer() {
    _key.currentState.openEndDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("Tokennnn ...... ");

    registerNotification();
    configLocalNotification();
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');

      // if()

      showNotification(message['notification']);

      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');

      FirebaseDatabase.instance
          .reference()
          .child("Token")
          .child("Admin")
          .set({"token": token}).then((_) {
        print("Token Update");
      }).catchError((err) => print(err));
    }).catchError((err) {
      print(err);
    });
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.colorbangla.super_fresh_admin'
          : 'com.duytq.flutterchatdemo',
      'Super Fresh Admin App',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
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
