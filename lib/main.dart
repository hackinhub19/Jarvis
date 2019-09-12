import 'package:flutter/material.dart';
import 'package:smartfarmland/ui/Smartfarm.dart';

void main()=> runApp(Main());



class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Smartfarm(),
    );
  }
}
