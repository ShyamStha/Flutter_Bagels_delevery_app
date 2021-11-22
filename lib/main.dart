import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/response.dart';

void main()
{
  runApp(MaterialApp(
    routes: {
      '/':(context)=>HomeScreen(),
      '/response':(context)=>Response(),
    },
   
  ));
}