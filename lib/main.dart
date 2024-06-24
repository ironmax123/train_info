import 'dart:convert';

import 'package:you_train_info/NextPage.dart';
import 'package:you_train_info/late.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:convert/convert.dart' show utf8;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:html/parser.dart' as parser;
import 'package:workmanager/workmanager.dart';
bool hankyu_flg=false,
    hanshin_flg=false,
    kintetu_flg=false,
    keihan_flg=false,
    nankai_flg=false,
    osaksametro_flg=false,
    kitakyu_flg=false,
    sanyou_flg=false,
    senboku_flg=false,
    ossakamono_flg=false,
    noseden_flg=false,
    hiei_flg=false,
    JRwest_flg=false,
    notice_flg=false;
void main() {

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get flutterLocalNotificationsPlugin => null;
  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '運行情報',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> co_list = [
    '阪急電鉄',
    '阪神電気鉄道',
    '近畿日本鉄道',
    '京阪電気鉄道',
    '南海電気鉄道',
    'Osaka Metro',
    '北大阪急行電鉄',
    '山陽電気鉄道',
    '泉北高速鉄道',
    '大阪高速鉄道(大阪モノレール)',
    '能勢電鉄',
    '比叡山電鉄',
    '西日本旅客鉄道(JR西)',
    '東海旅客鉄道(JR東海:東海道新幹線)',
    'テスト'
  ];

  get child => null;
  String text = '';


  @override
  void initState() {
    super.initState();
    _hankyu();
    _hanshin();
    _kintetu();
    _keihan();
    _nankai();
    _osakametro_midousuji();
    _osakametro_nagahori();
    _osakametro_nimazato();
    _osakametro_sakaisuji();
    _osakametro_sennichimae();
    _osakametro_tanimachi();
    _osakametro_tyuuou();
    _osakametro_yotuhashi();
    _kitakyuu();
    _sanyou();
    _senboku();
    _osakamono();
    _noseden();
    _hiei();
    _JRwest();
  }


  Future<void> _hankyu() async {
    final url = 'https://www.hankyu.co.jp/railinfo/index.html';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('運転を見合わせている')||bodyText.contains('電車に遅れが発生しています')) {
          co_list[0] = '❗️ 阪急電車';
          hankyu_flg=true;
        } else {
          co_list[0] = '阪急電鉄';
          hankyu_flg=false;
        }
      });
    } else {
      setState(() {
        text = 'Error(阪急電車): ${response.statusCode}';
      });
    }
  }
  Future<void> _hanshin() async {
    final url = 'https://www.hanshin.co.jp/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('30分')) {
          hanshin_flg=false;
          co_list[1] = '阪神電気鉄道';
        } else {
          co_list[1] = '❗️ 阪神電気鉄道';
          hanshin_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(阪神電気鉄道): ${response.statusCode}';
      });
    }
  }
  Future<void> _kintetu() async {
    final url = 'https://www.kintetsu.jp/unkou/unkou.html';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('30分')) {
          kintetu_flg=false;
          co_list[2] = '近畿日本鉄道';
        } else {
          co_list[2] = '❗️ 近畿日本鉄道';
          kintetu_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(近畿日本鉄道): ${response.statusCode}';
      });
    }
  }
  Future<void> _keihan() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/300/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          keihan_flg=false;
          co_list[3] = '京阪電気鉄道';
        } else {
          co_list[3] = '❗️ 京阪電気鉄道';
          keihan_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(京阪電気鉄道): ${response.statusCode}';
      });
    }
  }
  Future<void> _nankai() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/339/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          nankai_flg=false;
          co_list[4] = '南海電気鉄道';
        } else {
          co_list[4] = '❗️ 南海電気鉄道';
          nankai_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(南海電気鉄道): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakametro_midousuji() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/321/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          if(ossakamono_flg!=true){
            osaksametro_flg=false;
            co_list[5] = 'Osaka Metro';
          }
        } else {
          co_list[5] = '❗️ Osaka Metro';
          osaksametro_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(Osaka Metro): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakametro_tanimachi() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/322/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          if(ossakamono_flg!=true){
            osaksametro_flg=false;
            co_list[5] = 'Osaka Metro';
          }
        } else {
          co_list[5] = '❗️ Osaka Metro';
          osaksametro_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(Osaka Metro): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakametro_yotuhashi() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/323/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          if(ossakamono_flg!=true){
            osaksametro_flg=false;
            co_list[5] = 'Osaka Metro';
          }
        } else {
          co_list[5] = '❗️ Osaka Metro';
          osaksametro_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(Osaka Metro): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakametro_tyuuou() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/324/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          if(ossakamono_flg!=true){
            osaksametro_flg=false;
            co_list[5] = 'Osaka Metro';
          }
        } else {
        co_list[5] = '❗️ Osaka Metro';
        osaksametro_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(Osaka Metro): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakametro_sennichimae() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/325/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          if(ossakamono_flg!=true){
            osaksametro_flg=false;
            co_list[5] = 'Osaka Metro';
          }
        } else {
          co_list[5] = '❗️ Osaka Metro';
          osaksametro_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(Osaka Metro): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakametro_sakaisuji() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/326/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          if(ossakamono_flg!=true){
            osaksametro_flg=false;
            co_list[5] = 'Osaka Metro';
          }
        } else {
          co_list[5] = '❗️ Osaka Metro';
          osaksametro_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(Osaka Metro): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakametro_nagahori() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/327/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          if(ossakamono_flg!=true){
            osaksametro_flg=false;
            co_list[5] = 'Osaka Metro';
          }
        } else {
          co_list[5] = '❗️ Osaka Metro';
          osaksametro_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(Osaka Metro): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakametro_nimazato() async {
    final url = 'https://transit.yahoo.co.jp/diainfo/537/0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常運転')) {
          if(ossakamono_flg!=true){
            osaksametro_flg=false;
            co_list[5] = 'Osaka Metro';
          }
        } else {
          co_list[5] = '❗️ Osaka Metro';
          osaksametro_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(Osaka Metro): ${response.statusCode}';
      });
    }
  }
  Future<void> _kitakyuu() async {
    final url = 'https://www.kita-kyu.co.jp/info_train';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';


      setState(() {
        if (bodyText.contains('20分')) {
          kitakyu_flg=false;
          co_list[6] = '北大阪急行電鉄';
        } else {
          co_list[6] = '❗️ 北大阪急行電鉄';
          kitakyu_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(北大阪急行電鉄): ${response.statusCode}';
      });
    }
  }
  Future<void> _sanyou() async {
    final url = 'https://www.sanyo-railway.co.jp/railway/info.html';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';


      setState(() {
        if (bodyText.contains('30分')) {
          sanyou_flg=false;
          co_list[7] = '山陽電気鉄道';
        } else {
          co_list[7] = '❗️ 山陽電気鉄道';
          sanyou_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(北大阪急行電鉄): ${response.statusCode}';
      });
    }
  }
  Future<void> _senboku() async {
    final url = 'https://www.semboku.jp/station/traininfo/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('平常通り')) {
          senboku_flg=false;
          co_list[8] = '泉北高速鉄道';
        } else {
          co_list[8] = '❗️ 泉北高速鉄道';
          senboku_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(泉北高速鉄道): ${response.statusCode}';
      });
    }
  }
  Future<void> _osakamono() async {
    final url = 'https://www.osaka-monorail.co.jp/info/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';


      setState(() {
        if (bodyText.contains('平常通り')) {
          ossakamono_flg=false;
          co_list[9] = '大阪高速鉄道(大阪モノレール)';
        } else {
          co_list[9] = '❗️ 大阪高速鉄道(大阪モノレール)';
          ossakamono_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(大阪高速鉄道(大阪モノレール)): ${response.statusCode}';
      });
    }
  }
  Future<void> _noseden() async {
    final url = 'https://noseden.hankyu.co.jp/railway/railinfo/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('asguha')) {
          noseden_flg=false;
          co_list[10] = '能勢電鉄';
        } else {
          co_list[10] = '❗️ 能勢電鉄';
          noseden_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(能勢電鉄): ${response.statusCode}';
      });
    }
  }
  Future<void> _hiei() async {
    final url = 'https://eizandensha.co.jp/traininfo/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('30分以上')) {
          hiei_flg=false;
          co_list[11] = '比叡山電鉄';
        } else {
          co_list[11] = '❗️ 比叡山電鉄';
          hiei_flg=true;
        }
      });
    } else {
      setState(() {
        text = 'Error(比叡山電鉄): ${response.statusCode}';
      });
    }
  }
  Future<void> _JRwest() async {
    final url = 'https://trafficinfo.westjr.co.jp/kinki.html';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bodyBytes = response.bodyBytes;
      var bodyString = utf8.decode(bodyBytes);
      var document = parser.parse(bodyString);
      var bodyText = document.body?.text ?? '';

      setState(() {
        if (bodyText.contains('運行情報')){
          co_list[12] = '❗️ 西日本旅客鉄道(JR西)';
          JRwest_flg=true;
        }else{
          co_list[12] = '西日本旅客鉄道(JR西)';
          JRwest_flg=false;
        }
      });
    } else {
      setState(() {
        text = 'Error(西日本旅客鉄道(JR西)): ${response.statusCode}';
      });
    }
  }

  void abnormality() {
    _hankyu();
    _hanshin();
    _kintetu();
    _keihan();
    _nankai();
    _osakametro_midousuji();
    _osakametro_nagahori();
    _osakametro_nimazato();
    _osakametro_sakaisuji();
    _osakametro_sennichimae();
    _osakametro_tanimachi();
    _osakametro_tyuuou();
    _osakametro_yotuhashi();
    _kitakyuu();
    _sanyou();
    _senboku();
    _osakamono();
    _noseden();
    _hiei();
    _JRwest();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text('関西鉄道各社の運行情報'),
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            abnormality();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
      Row(
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black, shape: const StadiumBorder(),
              side: const BorderSide(color: Colors.green),
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => latePgae()),
              );
            },
            child: Text('web遅延証'),
          ),
          Text(text),
         IconButton(
            icon:Icon(Icons.notifications),
            onPressed: (){
              send_notice();
              Workmanager().registerPeriodicTask(
                "1",
                "simplePeriodicTask",
                frequency: Duration(minutes:5), // 5分おきにタスクを実行
              );
            },
          ),
        ],
      ),
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
                                context) => NextPage(co_list[index])));
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
void showLocalNotification(String title, String message) {
  const androidNotificationDetail = AndroidNotificationDetails(
      'channel_id', // channel Id
      'channel_name' // channel Name
  );
  const iosNotificationDetail = DarwinNotificationDetails();
  const notificationDetails = NotificationDetails(
    iOS: iosNotificationDetail,
    android: androidNotificationDetail,
  );
  FlutterLocalNotificationsPlugin()
      .show(0, title, message, notificationDetails);
}
void send_notice(){
  String train_co_mdg='';
  if (hankyu_flg==true){
    train_co_mdg='阪急';
    notice_flg=true;
  }
  if(hanshin_flg==true){
    train_co_mdg='阪神';
    notice_flg=true;
  }
  if(hanshin_flg==true){
    train_co_mdg='近鉄';
    notice_flg=true;
  }
  if(nankai_flg==true){
    train_co_mdg='南海';
    notice_flg=true;
  }
  if(noseden_flg=true){
    train_co_mdg='能勢電鉄';
    notice_flg=true;
  }
  else{
    notice_flg=false;
  }
  if(notice_flg==true){
    showLocalNotification('[$train_co_mdg]運行情報','一部路線に遅れや運休が出ています');
  }
  print('！！');
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    send_notice();
    return Future.value(true);
  });
}