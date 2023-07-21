import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///加载中
///cancelFunc:取消回调
class Loading extends StatefulWidget {
  final CancelFunc? cancelFunc;
  String? str;

  Loading({Key? key, this.cancelFunc,this.str}) : super(key: key);

  @override
  _LoadingWidget createState() => _LoadingWidget();
}

class _LoadingWidget extends State<Loading> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape:  RoundedRectangleBorder(
              borderRadius:  BorderRadius.all( Radius.circular(10))
            )
          ),
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(10),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  <Widget>[
              const CircularProgressIndicator(),
               Text(
                 '${widget.str ?? '正在加载'}...',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey
                ),
                softWrap: false
              )
            ],
          ),
        ),
      )
    );
  }
}