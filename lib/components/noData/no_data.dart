import 'package:flutter/material.dart';
import 'package:scet_plugin/tool/screen/screen.dart';
import 'package:scet_plugin/tool/time/utc_tolocal.dart';
///无状态页
class NoData extends StatelessWidget {
  bool margin;
  bool timeType;
  String? state;
  NoData({Key? key, this.margin = true, this.timeType = false, this.state}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ? EdgeInsets.fromLTRB(px(20.0), px(24.0), px(20.0), 0.0) : EdgeInsets.only(top: px(24.0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(px(12.0)))),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: px(80.0), horizontal: px(24.0)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(px(10.0))),
          gradient: const LinearGradient(
            colors: [Color(0XFF3992F5), Color(0XFF8267F0)]
          ),
        ),
        child: timeType 
        ? 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '$state',
                style: TextStyle(
                  fontSize: sp(32.0), 
                  color: Colors.white)
              ),
              Text(
                  '${ScetTime.wfUtcToLocal((DateTime.now().toString()))}',
                // DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
                style: TextStyle(
                  fontSize: sp(24.0), 
                  color: Colors.white
                )
              )
            ],
          )
        :
          Center(
            child: Text(
              '$state',
              style: TextStyle(
                fontSize: sp(32.0),
                color: Color(0XFFFFFFFF)
              )
            ),
          )
      )
    );
  }
}