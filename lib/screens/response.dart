import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Response extends StatefulWidget {
  final String uid;
  Response({this.uid});

  @override
  _ResponseState createState() => _ResponseState();
}

class _ResponseState extends State<Response> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  String reviewText;
  String rate;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Review',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.black,
              ),
              onPressed: () {
                _googleSignIn.signOut();
                Navigator.pop(context);
              }),
              Padding(
                padding: const EdgeInsets.only(top:18.0,right: 15.0),
                child: Text('Logout',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                ),
              )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  reviewText = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Review here',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {
                _controller.clear();
                Firestore.instance.collection('messages').add({
                  'review': reviewText,
                  'sender': widget.uid,
                  'rating': rate,
                });
                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("Thanks for your review"),
                  content: Text("You review has been successfully recorded."),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back'),
                    ),
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              child: Text('Send'),
            ),
            RatingBar(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                rate = rating.toString();
                print(rating);
              },
            ),
          ],
        ),
      ),
    );
  }
}
