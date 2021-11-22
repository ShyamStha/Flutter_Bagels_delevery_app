import 'package:bagelsnepal/screens/amount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'calc.dart';
import 'finalorder.dart';
//var quantity=4;

class ProdDetails extends StatefulWidget {
  final prod_text;
  final prod_pic;
  final prod_des;
  final prod_paisa;
  final pro_calories;
  final pro_carbohydrate;
  final pro_fat;
  final pro_protein;
  final pro_alcohol;
  final pro_fibre;
  double qty;
  var amount;

  ProdDetails({
    this.prod_pic,
    this.prod_text,
    this.prod_des,
    this.prod_paisa,
    this.pro_alcohol,
    this.pro_calories,
    this.pro_carbohydrate,
    this.pro_fat,
    this.pro_fibre,
    this.pro_protein,
    this.amount,
    this.qty,
    //this.quantity,
  });

  @override
  _ProdDetailsState createState() => _ProdDetailsState();
}

class _ProdDetailsState extends State<ProdDetails> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool exceptionCaught;
  bool showSpinner = false;

  bool isAuth = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<FirebaseUser> _signInGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final FirebaseUser firebaseuser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Calculation(
                userId: firebaseuser.email,
                money: Amount(quantity: widget.qty, amount: widget.prod_paisa)
                    .totAmount(),
                itemname: widget.prod_text,
                prod_Pic: widget.prod_pic,
                prod_qty: widget.qty,
              )));

      if (firebaseuser == null) {
        throw Exception('User is null');
      }
    } catch (e) {
      exceptionCaught = true;
      // rethrow;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Amount amt = Amount(quantity: widget.qty, amount: widget.prod_paisa);
    var amot = amt.totAmount();

    //var quantity=widget.qty;
    // var quantity=widget.qty;
    //var quantity=0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          widget.prod_text,
          style: TextStyle(
            color: Colors.brown[600],
            fontFamily: 'PatrickHand',
            fontSize: 40,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.asset(widget.prod_pic)),
                  Text(
                    widget.prod_text,
                    style: TextStyle(
                      fontFamily: 'PatrickHand',
                      fontSize: 30.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      widget.prod_des,
                      style: TextStyle(
                        fontFamily: 'PatrickHand',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Nutritions',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                        'New York Bagel Co Plain Bagel Calories and Nutrition per Serving (1 Serving=1 Bagel/84.7g)',
                        style: TextStyle(fontFamily: 'Patrickhand')),
                  ),
                  Rownutrition(
                    widget: widget,
                    text: 'Calories',
                    amount: widget.pro_calories,
                  ),
                  Rownutrition(
                    widget: widget,
                    text: 'Protein',
                    amount: widget.pro_protein,
                  ),
                  Rownutrition(
                    widget: widget,
                    text: 'Fat',
                    amount: widget.pro_fat,
                  ),
                  Rownutrition(
                    widget: widget,
                    text: 'Fibre',
                    amount: widget.pro_fibre,
                  ),
                  Rownutrition(
                    widget: widget,
                    text: 'Fat',
                    amount: widget.pro_fat,
                  ),
                  Rownutrition(
                    widget: widget,
                    text: 'Carbohydrate',
                    amount: widget.pro_carbohydrate,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Choose your quantity:'),
                      Slider(
                        activeColor: Colors.pink,
                          value: widget.qty,
                          min: 0,
                          max: 15,
                          divisions: 15,
                          label: '${widget.qty.toStringAsFixed(0)}',
                          onChanged: (value) {
                            setState(() {
                              widget.qty = value;
                            });
                          })
                    ],
                  ),
                  Text(
                    widget.qty.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                  Text(
                    'Your Total Amount is:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Rs $amot",
                      style: TextStyle(
                          fontFamily: 'PatrickHand',
                          fontSize: 30.0,
                          color: Colors.brown),
                    ),
                  ),
                  Text(
                    'Confirm Your Order Here',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  OutlineButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        await _signInGoogle();
                      } catch (e) {
                        print(e);
                      }
                       Fluttertoast.showToast(
                          msg: "Google SignedIn Successfully!!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0);
                      setState(() {
                        showSpinner = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    child: Text(
                      'Click Here For Your Order',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(fontSize: 40.0,
                    fontFamily: 'PatrickHand'
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'CallUsNowByPressingHere',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 30.0,
                          ),
                          onPressed: () {
                            launch("tel://9849757079");
                            // 'name': widget.prod_text,
                            // 'quantiy': widget.qty.toStringAsFixed(0),
                            // 'total': amot,
                            // 'requestedBy':
                          })
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // String updateValue() {
  //    return _amount.totAmount();
  // }
}

class Rownutrition extends StatelessWidget {
  const Rownutrition({Key key, @required this.widget, this.amount, this.text})
      : super(key: key);

  final ProdDetails widget;
  final String text;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(amount),
      ],
    );
  }
}
