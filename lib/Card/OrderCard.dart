import 'package:flutter/material.dart';
import 'package:super_fresh_admin/Order/OrderDestails.dart';

class OrderCard extends StatelessWidget {
  final name;
  final image;
  final number;
  final order_qunatity;
  final address;
  final k;
  final gmail;
  final quantity;
  final price;

  OrderCard(
      {this.name,
      this.number,
      this.image,
      this.address,
      this.order_qunatity,
      this.k,
      this.gmail,
      this.quantity,
      this.price});

  @override
  Widget build(BuildContext context) {
    // print("Imageeeeeeeeeeeeeee  ${image}");

    return InkWell(
      onTap: () {
        if (k != null) {
          /*
          *  image: list_image[index],
              address: list_price[index] , /// order details price
            //  number: list_name[index],
              name:list_name[index],
              order_qunatity: list_quantity[index],
          * */

          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => OrderDetails(
                    gmail: gmail,
                  )));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0.5, blurRadius: 0.5)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                //TODO image

                _image_display(image),

                SizedBox(
                  width: 10,
                ),

                //TODO name catagory price quanity
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    k != null
                        ? Text(
                            "${number}",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          )
                        : Container(),
                    Text(
                      "${address}",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(" ${order_qunatity}"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _image_display(image) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: image != null
            ? DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)
            : null,
      ),
      width: 65,
      height: 65,
    );
  }
}
