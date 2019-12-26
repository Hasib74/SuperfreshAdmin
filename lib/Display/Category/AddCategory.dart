import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_fresh_admin/Model/Category.dart';
import 'package:super_fresh_admin/Model/MPopular.dart';
import 'package:super_fresh_admin/Utils/Common.dart';

class AddCategory extends StatefulWidget {
  MCategory update_category;

  AddCategory({this.update_category});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  var _name_controller = new TextEditingController();

  File _selected_image;

  var _selected_catagry;

  bool loading = false;

  List<String> _key = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.update_category != null) {
      _name_controller.text = widget.update_category.name;
    }

    FirebaseDatabase.instance
        .reference()
        .child(Common.category)
        .once()
        .then((v) {
      Map<dynamic, dynamic> _catrgory = v.value;

      _catrgory.forEach((k, v) {
        _key.add(k);
      });
    });

    //_catagory_name_and_id();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            _add_image(),
            _name(),
            _save(),
          ],
        ),
        loading == true
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Common.orange_color,
                ),
              )
            : Container(),
      ],
    ));
  }

  _add_image() {
    return widget.update_category == null
        ? Padding(
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
                            fit: BoxFit.cover,
                            image: FileImage(_selected_image))
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
          )
        : Padding(
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
                            fit: BoxFit.cover,
                            image: FileImage(_selected_image))
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "${widget.update_category.image}",
                            )),
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

            labelText: 'Category Name',
          ),
          style: TextStyle(color: Colors.black54),
          cursorColor: Colors.black54,
        ),
      ),
    );
  }

  _save() {
    // print("Keyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy   ${_key[_key.length-1]}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        height: 45,
        child: new RaisedButton(
          onPressed: () {
            if (/*_selected_image != null &&*/
                _name_controller.value.text != null) {
              setState(() {
                loading = true;
              });

              if (widget.update_category == null) {
                uploadImage();
              } else {
                if (_selected_image == null) {
                  FirebaseDatabase.instance
                      .reference()
                      .child(Common.category)
                      .child(widget.update_category.id)
                      .update({
                    "name": _name_controller.value.text,
                    "image": widget.update_category.image,
                  }).then((_) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.of(context).pop();
                    //  widget.chnagePage();
                  }).catchError((err) {
                    print(err);
                  });
                } else {
                  _image_upload_abd_update();
                }
              }

              setState(() {
                loading = true;
              });
            } else {
              setState(() {
                loading = false;
              });

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

  void uploadImage() async {
    print("Name Controller  ${_name_controller.value.text}");

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toString()}');
    StorageUploadTask uploadTask = storageReference.putFile(_selected_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      if (widget.update_category == null) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.category)
            .push()
            .set({
          "name": _name_controller.value.text,
          "image": fileURL,
        }).then((_) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pop();
          //  widget.chnagePage();
        }).catchError((err) {
          print(err);
        });
      } else {
        FirebaseDatabase.instance
            .reference()
            .child(Common.category)
            .child(widget.update_category.id)
            .update({
          "name": _name_controller.value.text,
          "image": fileURL,
        }).then((_) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pop();
          //  widget.chnagePage();
        }).catchError((err) {
          print(err);
        });
      }
    });
  }

  void _image_upload_abd_update() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toString()}');
    StorageUploadTask uploadTask = storageReference.putFile(_selected_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      if (widget.update_category == null) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.category)
            .push()
            .set({
          "name": _name_controller.value.text,
          "image": fileURL,
        }).then((_) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pop();
          //  widget.chnagePage();
        }).catchError((err) {
          print(err);
        });
      } else {
        FirebaseDatabase.instance
            .reference()
            .child(Common.category)
            .child(widget.update_category.id)
            .update({
          "name": _name_controller.value.text,
          "image": fileURL,
        }).then((_) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pop();
          //  widget.chnagePage();
        }).catchError((err) {
          print(err);
        });
      }
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selected_image = image;
    });
  }
}
