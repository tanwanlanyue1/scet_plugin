import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scet_plugin/components/down_input/down_input.dart';
import 'package:scet_plugin/components/photoView/photo_view.dart';
import 'package:scet_plugin/scet_plugin.dart';
import 'package:scet_plugin/tool/router_animate/router_fade_route.dart';

void main() {
  // 自定义报错页面（打包后显示）
  if (kReleaseMode) {
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      debugPrint(flutterErrorDetails.toString());
      return const Material(
        child: Center(
            child: Text(
              "当前数据异常或缺失，请联系开发者，并返回",
              textAlign: TextAlign.center,
            )
        ),
      );
    };
  }

  // 捕获并上报 Dart 异常（开发版）
  runZonedGuarded(() async {
    // await Global.init();
    const MyApp();
  }, (Object error, StackTrace stack) {
    // ignore_for_file: avoid_print
    print('出错：error==>,$error \n 出错：stack==>,$stack\n');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '123',
      builder: ScetPlugin().botToastInit(), //1. call BotToastInit
      navigatorObservers: [ScetPlugin().botToastNavigatorObserver()],
      routes: {},//2
      home: pages()
    );
  }
}
class pages extends StatefulWidget {
  const pages({Key? key}) : super(key: key);

  @override
  State<pages> createState() => _pagesState();
}

class _pagesState extends State<pages> {

  final List _downInputData = [
    {'id':'1','name':'我是待选项1','value':'待选项1'}
  ];

  Map _currentData = {'id':'1','name':'我是待选项1','value':'待选项1'};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app1'),
      ),
      body: ListView(
        children: [
          InkWell(
            child: Text('获取图片'),
            onTap: (){
              Navigator.of(context).push(FadeRoute(page: PhotoViewGalleryScreen(
                images:['https://img1.baidu.com/it/u=1960110688,1786190632&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281'],//传入图片list
                index: 0,//传入当前点击的图片的index
                // heroTag: _img[index],//传入当前点击的图片的hero tag （可选）
              )));
            },
          ),
          DownInput(
            hitStr: '请选择站点',
            value: '选中的时候显示的内容',
            data: _downInputData,
            currentData: _currentData,
            callback: (val) {
              _currentData = val;
              setState(() { });
            },
          ),
        ],
      ),
    );
  }
}
