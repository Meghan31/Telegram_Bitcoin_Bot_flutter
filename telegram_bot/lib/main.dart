// teledart.start();
// teledart.onMessage(keyword: 'hai').listen((event) {
//   event.reply('Hai juga');
// });
// teledart
//     .onMessage(keyword: 'dart')
//     .where((message) => message.text!.contains('dart'))
//     .listen((message) => message.reply('Flutter is better'));
// 01cc2b0d34e926f354f09de00f829ad30a3268a5fe8f13fc5ecdb1a17990b8ce

import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:flutter/material.dart';
import 'package:teledart/model.dart';

import 'bitcoin_telegram_bot.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Update',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BitcoinTelegramBot(),
      debugShowCheckedModeBanner: false,
    );
  }
}
