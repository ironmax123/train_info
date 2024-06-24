import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:you_train_info/late.dart';
class latepage extends StatelessWidget {
  final String Train_co;
  const latepage(this.Train_co,{super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(Train_co: Train_co),
    );
  }
}
class MyHomePage extends StatefulWidget {
  final String Train_co;

  const MyHomePage({required this.Train_co, Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url='';
  @override
  Widget build(BuildContext context) {
    if (widget.Train_co=='阪急電鉄'){
      url='https://www.hankyu.co.jp/delay/index.html';
    }else if(widget.Train_co=='Osaka Metro') {
      url = 'https://subway.osakametro.co.jp/delay_list.php';
    }else if(widget.Train_co=='阪神電気鉄道') {
      url = 'https://www.hanshin.co.jp/system/delay';
    }else if(widget.Train_co=='近畿日本鉄道') {
      url = 'https://www.kintetsu.co.jp/gyoumu/delay/';
    }else if(widget.Train_co=='京阪電気鉄道'){
      url='https://www.keihan.co.jp/traffic/traintraffic/delay/';
    }else if(widget.Train_co=='能勢電鉄') {
      url = 'https://noseden.hankyu.co.jp/railway/delay/';
    }else if(widget.Train_co=='西日本旅客鉄道(JR西)') {
      url = 'https://delay.trafficinfo.westjr.co.jp/pc';
    }else if(widget.Train_co=='南海電気鉄道'){
      url='https://www.traffic.nankai.co.jp/delay';
    }else if(widget.Train_co=='北大阪急行電鉄'){
      url='https://www.kita-kyu.co.jp/info_train/certificate/';
    }else if(widget.Train_co=='山陽電気鉄道'){
      url='https://www.sanyo-railway.co.jp/railway/delay/index.html';
    }else if(widget.Train_co=='大阪高速鉄道(大阪モノレール)'){
      url='https://www.osaka-monorail.co.jp/delay/';
    }else if(widget.Train_co=='比叡山電鉄'){
      url='https://eizandensha.co.jp/delay_certificate/list/';
    }else{
      url='https://devapp.cloudfree.jp/error_page/';
    }
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Column(children: [
          const Text('表示中の鉄道会社'),
          Text(widget.Train_co)
        ]),
      ),
      body:
      WebViewWidget(controller: controller),
    );
  }
}