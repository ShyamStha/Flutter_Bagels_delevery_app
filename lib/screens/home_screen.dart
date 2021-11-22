import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'drawer.dart';

import 'prod_details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var prod_list = [
      {
        'image': 'images/plainbagel.jpg',
        'text': 'Plain',
        'description':
            'Our classic soft, chewy and thick New York–style bagel: whether toasted or not, or with a smear of cream cheese or not, each bite tastes of authentic-baked goodness.',
        'price': 'Rs 400',
        'calories': '216',
        'protein': '7.7',
        'carbohydrate': '42.7',
        'fat': '1.6',
        'fibre': '2.5',
        'alcohol': '0'
      },
      {
        'image': 'images/cinnamon.jpg',
        'text': 'Cinnamon',
        'description':
            'Our New York-style boiled bagel gets sweet cinnamon swirled into the dough, just before heaps of raisins are mixed in, adding a little sweet to your savory breakfast.',
        'price': 'Rs 500',
        'calories': '215',
        'protein': '6.5',
        'carbohydrate': '43.4',
        'fat': '1.7',
        'fibre': '3.8',
        'alcohol': '0'
      },
      {
        'image': 'images/cheese.jpg',
        'text': 'Cheese',
        'description': 'java is the best programming language',
        'price': 'Rs 450',
        'quantuty': '1',
        'calories': '215',
        'protein': '6.5',
        'carbohydrate': '43.4',
        'fat': '1.7',
        'fibre': '3.8',
        'alcohol': '0'
      },
      {
        'image': 'images/malt.jpg',
        'text': 'Malt',
        'description': 'sweety sweerty tera sweety like is a preety girl',
        'price': 'Rs 400',
        'quantuty': '1',
        'calories': '215',
        'protein': '6.5',
        'carbohydrate': '43.4',
        'fat': '1.7',
        'fibre': '3.8',
        'alcohol': '0'
      },
      {
        'image': 'images/sesame.jpg',
        'text': 'Sesame',
        'description': 'honey is the best alternative against sugar',
        'price': 'Rs 400',
        'quantuty': '1',
        'calories': '215',
        'protein': '6.5',
        'carbohydrate': '43.4',
        'fat': '1.7',
        'fibre': '3.8',
        'alcohol': '0'
      },
      {
        'image': 'images/everything.jpg',
        'text': 'Everything',
        'description':
            'Our signature New York–style bagel topped with onion, garlic, salt, poppy and sesame seeds.',
        'price': 'Rs 300',
        'quantuty': '1',
        'calories': '215',
        'protein': '6.5',
        'carbohydrate': '43.4',
        'fat': '1.7',
        'fibre': '3.8',
        'alcohol': '0'
      },
    ];

    List<int> paisa = [
      400,
      500,
      450,
      300,
      360,
      400,
    ];
    // List<int> qnt = [1, 3, 8, 6, 4, 7];
    Widget imagecarousel = Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/bagel1.jpg'),
          AssetImage('images/bagel3.jpg'),
          AssetImage('images/bagel3.jpg'),
          AssetImage('images/bagels4.jpg'),
          AssetImage('images/bagels5.jpg'),
          AssetImage('images/bagels6.jpg'),
        ],
        animationCurve: Curves.fastOutSlowIn,
        dotColor: Colors.brown,
        dotSpacing: 30.0,
        dotSize: 6.0,
        indicatorBgPadding: 1.0,
        borderRadius: true,
        // moveIndicatorFromBottom: 180.0,
        overlayShadow: true,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.brown),
        ),
        // leading: Icon(
        //   Icons.fastfood,
        //   color: Colors.black,
        // ),
        actions: <Widget>[
          Icon(
            Icons.sms,
            color: Colors.black,
          ),
        ],
      ),
      drawer: Draw(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          imagecarousel,
          Text(
            'Menus',
            style: TextStyle(
                fontSize: 20.0, fontFamily: 'Geo', fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: prod_list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Single_prod(
                      prod_image: prod_list[index]['image'],
                      prod_name: prod_list[index]['text'],
                      prod_descrp: prod_list[index]['description'],
                      prod_price: paisa[index],
                      prod_calories: prod_list[index]['calories'],
                      prod_carbohydrate: prod_list[index]['carbohydrate'],
                      prod_fat: prod_list[index]['fat'],
                      prod_alcohol: prod_list[index]['alcohol'],
                      prod_fibre: prod_list[index]['fibre'],
                      prod_protein: prod_list[index]['protein'],
                    );
                  }))
        ],
      ),
    );
  }
}

class Single_prod extends StatelessWidget {
  int quantity = 0;

  final String prod_image;
  final String prod_name;
  final String prod_descrp;
  final int prod_price;

  final String prod_calories;
  final String prod_protein;
  final String prod_carbohydrate;
  final String prod_fat;
  final String prod_fibre;
  final String prod_alcohol;

  Single_prod({
    this.prod_image,
    this.prod_name,
    this.prod_descrp,
    this.prod_price,
    this.prod_alcohol,
    this.prod_calories,
    this.prod_carbohydrate,
    this.prod_fat,
    this.prod_fibre,
    this.prod_protein,

    //this.quantity,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Card(
        child: Material(
          child: InkWell(
            onTap: () {
              //Amount amt = Amount(amount: prod_price,quantity: quantity);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProdDetails(
                          prod_pic: prod_image,
                          prod_text: prod_name,
                          prod_des: prod_descrp,
                          //prod_qty: prod_quantity,
                          pro_alcohol: prod_alcohol,
                          pro_calories: prod_calories,
                          pro_carbohydrate: prod_carbohydrate,
                          pro_fat: prod_fat,
                          pro_fibre: prod_fibre,
                          pro_protein: prod_protein,
                          //amount: amt.totAmount(),
                          qty: quantity.toDouble(),
                          prod_paisa: prod_price.toDouble(),
                        )),
              );
            },
            child: GridTile(
                footer: Container(
                  height: 45.0,
                  child: ListTile(
                    trailing: Text(prod_price.toString()),
                    leading: Text(
                      prod_name,
                      style: TextStyle(
                        fontFamily: 'PatrickHand',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  color: Colors.white60,
                ),
                child: Image.asset(
                  prod_image,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
