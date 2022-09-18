import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:flutter/material.dart';
import 'package:teledart/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinTelegramBot extends StatefulWidget {
  const BitcoinTelegramBot({Key? key}) : super(key: key);

  @override
  State<BitcoinTelegramBot> createState() => _BitcoinTelegramBotState();
}

class _BitcoinTelegramBotState extends State<BitcoinTelegramBot> {
  bool? isStart;
  double change = 0;
  double currentValueRupee = 0;
  double currentValueUSD = 0;
  double preValue = 0;
  var _time = '';
  var _time1 = '';
  var _time2 = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Image.network(
          'https://www.businessinsider.in/photo/photo/88516398/88516398.jpg?imgsize',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Row(children: [
          SizedBox(
            width: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Column(
                  children: [
                    (isStart == true)
                        ? (Row(children: [
                            Card(
                              elevation: 20,
                              color: Colors.white24,
                              child: Container(
                                width: 200,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(_time,
                                        style: TextStyle(
                                            color: Colors.amber[700],
                                            decoration: TextDecoration.none,
                                            fontSize: 20,
                                            fontFamily: 'Brand-Regular',
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ]))
                        : (Container()),
                    RaisedButton(
                        onPressed: () async {
                          setState(() {
                            isStart = true;
                          });

                          var BOT_TOKEN =
                              '5789984356:AAEviyrazluugloxqjOz-MCpWpCpi0qTa30';
                          final username =
                              (await Telegram(BOT_TOKEN).getMe()).username;
                          var teledart = TeleDart(BOT_TOKEN, Event(username!));
                          teledart.start();
                          var url =
                              'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,INR&=01cc2b0d34e926f354f09de00f829ad30a3268a5fe8f13fc5ecdb1a17990b8ce';

                          print('Date, BTC Price in USD, BTC Price in INR');
                          while (isStart!) {
                            String currentTime =
                                DateFormat.jms().format(DateTime.now());

                            var response = await http.get(Uri.parse(url));
                            var data = response.body;
                            var index = data.indexOf('USD');
                            var index1 = data.indexOf('INR');
                            var index2 = data.indexOf('}');
                            var valueUSD =
                                data.substring(index + 5, index1 - 2);
                            var valueRupee = data.substring(index1 + 5, index2);
                            currentValueUSD = double.parse(valueUSD);
                            currentValueRupee = double.parse(valueRupee);
                            if (preValue == 0) {
                              preValue = currentValueUSD;
                            } else {
                              change = currentValueUSD - preValue;
                              preValue = currentValueUSD;
                            }
                            print(
                                '${DateFormat.jms().format(DateTime.now())},   USD: \$$currentValueUSD,   INR: ₹$currentValueRupee');
                            _time2 =
                                'Prices   at :  ${DateFormat.jms().format(DateTime.now())},';
                            setState(() {
                              _time =
                                  'USD: \$$currentValueUSD\nINR ₹$currentValueRupee';
                            });
                            if (change > 0) {
                              teledart.sendMessage('-659106069',
                                  'Bitcoin Price in USD: $currentValueUSD\nBitcoin Price in Rupee: $currentValueRupee\nChange: $change');
                            } else if (change < 0) {
                              teledart.sendMessage('-659106069',
                                  'Bitcoin Price in USD: $currentValueUSD\nBitcoin Price in Rupee: $currentValueRupee\nChange: $change');
                            } else {
                              teledart.sendMessage('-659106069',
                                  'Bitcoin Price in USD: $currentValueUSD\nBitcoin Price in Rupee: $currentValueRupee\nChange: $change');
                            }

                            await Future.delayed(Duration(seconds: 3));
                          }
                        },
                        child: Text('Start')),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Text('Stop'),
                      onPressed: () {
                        setState(() {
                          isStart = false;
                          _time1 = _time;
                          _time = '';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 80,
                ),
              ]),
              SizedBox(
                height: 60,
              ),
              (isStart == false)
                  ? (Row(children: [
                      Text(
                        _time2,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontFamily: 'Signatra',
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                    ]))
                  : Container(),
              (isStart == false)
                  ? (Row(children: [
                      Card(
                        elevation: 20,
                        color: Colors.white24,
                        child: Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Text(_time1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'Brand-Bold',
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                    ]))
                  : Container(),
            ],
          ),
        ]),
      ]),
    );
  }
}
