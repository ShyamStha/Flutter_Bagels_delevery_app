import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'response.dart';

class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
 
  bool showSpinner = false;
  bool exceptionCaught;
   FirebaseAuth _auth = FirebaseAuth.instance;

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
          builder: (BuildContext context) => Response(
                uid: firebaseuser.email,
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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: UserAccountsDrawerHeader(
                arrowColor: Colors.black,
                accountName: Text('BagelsNepal'),
                accountEmail: Text('BagelNepal@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('images/bagel1.jpg'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.brown,
                ),
                title: Text('Home'),
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
                title: Text('Menus'),
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                title: Text(
                  'Contact',
                ),
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.userFriends,
                  color: Colors.pink,
                ),
                title: Text('AboutUs'),
              ),
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  await _signInGoogle();
                } catch (e) {
                  print(e);
                }
                setState(() {
                  showSpinner = false;
                });
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.comment,
                  color: Colors.blueAccent,
                ),
                title: Text('Feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
