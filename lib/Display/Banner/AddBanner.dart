import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class AddBanner extends StatefulWidget {


 // Function chnagePage;

 // AddBanner({Key key ,this.chnagePage}):super(key:key);
  @override
  _AddBannerState createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  File _selected_image;

  var _selected_catagry;

  var _uploadedFileURL;

  var _name_controller = new TextEditingController();
  var _discount_controller = new TextEditingController();
  var _discription_controller = new TextEditingController();
  var _price_controller = new TextEditingController();
  var _rating_controller = new TextEditingController();
  var _previous_price_controller = new TextEditingController();


  bool loading=false;

  // var _name_controller=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          ListView(
            children: <Widget>[
              _add_image(),
              _name(),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: _itemDown(),
              ),

              _price(),

              _previous_price(),

              _discount(),

              _discription(),

              _save(),

              //_product_id(),
            ],
          ),


          loading ? Center(
            child: CircularProgressIndicator(backgroundColor: Colors.deepOrange,),

          ):Container()


        ],
      ),
    );
  }

  _add_image() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          /*     if(_selected_image==null){*/

          getImage();

          /*   }*/
        },
        child: Container(
            // duration: Duration(milliseconds: 500),
            height: 170,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    // blurRadius: 2,
                    spreadRadius: 0.6),
              ],
              image: _selected_image != null
                  ? DecorationImage(
                      fit: BoxFit.cover, image: FileImage(_selected_image))
                  : null,
            ),
            child: _selected_image == null
                ? Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.black38,
                      size: 40,
                    ),
                  )
                : Container()),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selected_image = image;
    });
  }

  _name() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Theme(
        data: new ThemeData(
          primaryColor: Colors.black54,
          primaryColorDark: Colors.black54,
        ),
        child: new TextField(
          controller: _name_controller,
          autofocus: false,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)),
            // hintText: 'Product Name',

            labelText: 'Product Name',
          ),
          style: TextStyle(color: Colors.black54),
          cursorColor: Colors.black54,
        ),
      ),
    );
  }

  DropdownButton _itemDown() => DropdownButton<String>(
        focusColor: Common.orange_color,
        iconEnabledColor: Colors.black54,
        autofocus: false,

        /*  selectedItemBuilder: (d){

          print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD  ${d}");

        },
*/

        items: [
          DropdownMenuItem(
            value: "01",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Jewellery",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: "02",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Electronics",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: "03",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Gadgets",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: "04",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Beauty and Health",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _selected_catagry = value;
          });
        },
        value: _selected_catagry,
        isExpanded: true,


      );

  _price() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Theme(
        data: new ThemeData(
          primaryColor: Colors.black54,
          primaryColorDark: Colors.black54,
        ),
        child: new TextField(
          controller: _price_controller,
          autofocus: false,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)),
            // hintText: 'Product Name',

            labelText: 'Price',
          ),
          style: TextStyle(color: Colors.black54),
          cursorColor: Colors.black54,
        ),
      ),
    );
  }

  _previous_price() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Theme(
        data: new ThemeData(
          primaryColor: Colors.black54,
          primaryColorDark: Colors.black54,
        ),
        child: new TextField(
          controller: _previous_price_controller,
          autofocus: false,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)),
            // hintText: 'Product Name',

            labelText: 'Previous Price',
          ),
          style: TextStyle(color: Colors.black54),
          cursorColor: Colors.black54,
        ),
      ),
    );
  }

  _discount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Theme(
        data: new ThemeData(
          primaryColor: Colors.black54,
          // primaryColor: Colors.black54,
        ),
        child: new TextField(
          controller: _discount_controller,
          autofocus: false,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)),
            // hintText: 'Product Name',

            labelText: 'Discount',
          ),
          style: TextStyle(color: Colors.black54),
          cursorColor: Colors.black54,
        ),
      ),
    );
  }

  _discription() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          color: Common.background_color,
          padding: EdgeInsets.all(0.0),
          child: new ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 200.0,
              ),
              child: SizedBox(
                height: 190.0,
                child: new TextField(
                  controller: _discription_controller,
                  style: TextStyle(color: Colors.black54),
                  cursorColor: Colors.black54,
                  maxLines: 100,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                    ),
                  ),
                ),
              )),
        ));
  }

  _save() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        height: 45,
        child: new RaisedButton(
          onPressed: () {


            print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS  ${_selected_catagry.toString()}");


            if (_selected_image != null &&
                _name_controller.value.text != null &&
                _discount_controller.value.text != null &&
                _price_controller.value.text != null &&
                _discription_controller.value.text != null &&
                _previous_price_controller.value.text != null &&
                _selected_catagry != null) {
              uploadImage();


              setState(() {


                loading=true;

              });

            } else {
              print("Empty");
            }
          },
          color: Colors.deepOrange,
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  String _category() {
    String v;

    if (_selected_catagry == "Jewellery") {
      v = "01";
    } else if (_selected_catagry == "Electronics") {
      v = "02";
    } else if (_selected_catagry == "Gadgets") {
      v = "03";
    } else if (_selected_catagry == "Beauty and Health") {
      v = "04";
    }
    //Gadgets

    return v;
  }

  void uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toString()}');
    StorageUploadTask uploadTask = storageReference.putFile(_selected_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      FirebaseDatabase.instance
          .reference()
          .child(Common.banner)
          .child(new DateTime.now()
              .toIso8601String()
              .replaceAll(".", "")
              .replaceAll("-", "")
              .replaceAll("T", "").replaceAll(":", ""))
          .set({
        "name": _name_controller.value.text,
        "price": _price_controller.value.text,
        "discount": _discount_controller.value.text,
        "description": _discription_controller.value.text,
        "catagory_id": _selected_catagry,
        "image": fileURL
      }).then((_) {

        setState(() {


          loading=false;

        });


        Navigator.of(context).pop();
     //  widget.chnagePage();
      }).catchError((err){



        print(err);
/*
        setState(() {


          loading=false;

        });*/

      });
    });
  }



}
