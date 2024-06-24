import 'package:you_train_info/NextPage.dart';
import 'package:you_train_info/latepage.dart';
import 'package:flutter/material.dart';

import 'main.dart';
class latePgae extends StatefulWidget {
  latePage(String co_list) {
    // TODO: implement latePage
    throw UnimplementedError();
  }

  @override
  _latePageState createState() => _latePageState();
}

class _latePageState extends State<latePgae> {
  List<String> co_list = [
    '阪急電鉄',
    '阪神電気鉄道',
    '近畿日本鉄道',
    '京阪電気鉄道',
    '南海電気鉄道',
    'Osaka Metro',
    '北大阪急行電鉄',
    '山陽電気鉄道',
    '大阪高速鉄道(大阪モノレール)',
    '能勢電鉄',
    '比叡山電鉄',
    '西日本旅客鉄道(JR西)'
  ];

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor:
        Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text('関西鉄道各社の遅延証明書'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: co_list.length,
                itemBuilder: (context, index) {
                  return Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.train),
                          title: Text(co_list[index]),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => latepage(co_list[index])));
                          },
                        ),
                        const Divider(height: 0,),
                      ]
                  );
                }
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}