import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';
class NextPage extends StatelessWidget {
  final String Train_co;
  const NextPage(this.Train_co,{super.key});
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
  String west='';
  @override
  Widget build(BuildContext context) {
    if (widget.Train_co=='阪急電鉄'||widget.Train_co=='❗️ 阪急電鉄'){
      url='https://www.hankyu.co.jp/railinfo/index.html';
    }else if(widget.Train_co=='Osaka Metro'||widget.Train_co=='❗️ Osaka Metro') {
      url = 'https://subway.osakametro.co.jp/guide/subway_information.php';
    }else if(widget.Train_co=='阪神電気鉄道'||widget.Train_co=='❗️ 阪神電気鉄道') {
      url = 'https://www.hanshin.co.jp/';
    }else if(widget.Train_co=='近畿日本鉄道'||widget.Train_co=='❗️ 近畿日本鉄道') {
      url = 'https://www.kintetsu.jp/unkou/unkou.html';
    }else if(widget.Train_co=='京阪電気鉄道'||widget.Train_co=='❗️ 京阪電気鉄道'){
      url='https://www.keihan.co.jp/traffic/traintraffic/';
    }else if(widget.Train_co=='能勢電鉄'||widget.Train_co=='❗️ 能勢電鉄') {
      url = 'https://noseden.hankyu.co.jp/railway/railinfo/';
    }else if(widget.Train_co=='西日本旅客鉄道(JR西)'||widget.Train_co=='❗️ 西日本旅客鉄道(JR西)') {
      url='https://trafficinfo.westjr.co.jp/kinki.html';
      west='詳しくはWESTERをご確認ください';
    }else if(widget.Train_co=='東海旅客鉄道(JR東海:東海道新幹線)'||widget.Train_co=='❗️ 東海旅客鉄道(JR東海:東海道新幹線)') {
      url = 'https://traininfo.jr-central.co.jp/shinkansen/sp/ja/index.html';
    }else if(widget.Train_co=='南海電気鉄道'||widget.Train_co=='❗️ 南海電気鉄道'){
      url='https://www.traffic.nankai.co.jp/railinfo/01.html';
    }else if(widget.Train_co=='北大阪急行電鉄'||widget.Train_co=='❗️ 北大阪急行電鉄'){
      url='https://www.kita-kyu.co.jp/info_train/';
    }else if(widget.Train_co=='山陽電気鉄道'||widget.Train_co=='❗️ 山陽電気鉄道'){
      url='https://www.sanyo-railway.co.jp/railway/info.html';
    }else if(widget.Train_co=='泉北高速鉄道'||widget.Train_co=='❗️ 泉北高速鉄道'){
      url='https://www.semboku.jp/station/traininfo/';
    }else if(widget.Train_co=='大阪高速鉄道(大阪モノレール)'||widget.Train_co=='❗️ 大阪高速鉄道(大阪モノレール)'){
      url='https://www.osaka-monorail.co.jp/info/';
    }else if(widget.Train_co=='比叡山電鉄'||widget.Train_co=='❗️ 比叡山電鉄'){
      url='https://eizandensha.co.jp/traininfo/';
    }else{
      url='https://devapp.cloudfree.jp/error_page/';
    }
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(
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