import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Calculation extends StatefulWidget {
  final userId;
  final money;
  final itemname;
  final prod_Pic;
  final prod_qty;
  Calculation(
      {this.userId, this.money, this.itemname, this.prod_Pic, this.prod_qty});
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  //  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) {
  //       print('on message $message');
  //     },
  //     onResume: (Map<String, dynamic> message) {
  //       print('on resume $message');
  //     },
  //     onLaunch: (Map<String, dynamic> message) {
  //       print('on launch $message');
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.getToken().then((token) {
  //     print(token);
  //   });
  // }
  var time=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Confirmation Order',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'PatrickHand',
            fontSize: 30.0,
          ),
        ),
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 200.0,
              width: double.infinity,
              color: Colors.red,
              child: Image.asset(
                widget.prod_Pic,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Item You Have Choosen:',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                widget.itemname,
                style: TextStyle(fontSize: 30.0, fontFamily: 'PatrickHand'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Quantity You Have Choosen:',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                widget.prod_qty.toString(),
                style: TextStyle(fontSize: 30.0, fontFamily: 'PatrickHand'),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Text(
            'Your Total Amount is:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40.0, fontFamily: 'PatrickHand'),  
          ),
          Text(
            'Rs ${widget.money}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.only(left: 90.0, right: 90.0),
            child: RaisedButton(
              onPressed: () {
                
                Firestore.instance.collection('orders').add({
                    'item':widget.itemname,
                    'orderedby':widget.userId,
                    'quantity':widget.prod_qty,
                    'time':time.toString().substring(0,time.toString().length-7),
                    'pic':widget.prod_Pic,
                   

                });
                 Fluttertoast.showToast(
                          msg: "Your order has been sucessfully recorded..Thankyous!!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0);
              },
              child: Text(
                'Order Now',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                    fontFamily: 'PatrickHand'),
              ),
              color: Colors.lightGreen,
            ),
          )
        ],
      ),
    );
  }
}
