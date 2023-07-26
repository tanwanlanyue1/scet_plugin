import 'package:flutter/material.dart';
import 'package:scet_plugin/scet_plugin.dart';
import 'package:scet_plugin/tool/screen/screen.dart';

/// 自定义ui
class ScetUi{

  static init(GlobalKey<NavigatorState> key){
    print('---中联兴uiz组件件初始化---');
    navigatorKey = key;
  }
  /// 需要初始化的时候传入一个全局的navigatorKey 作为上下文
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// 定制的Appbar
  /// title : 标题
  /// leadingType 返回按钮样式
  /// leadingOnTap 返回按钮附带事件
  /// customLeading 自定义的返回样式
  /// actionsChild 右侧按钮自定义
  /// homeRouterStr 返回路由的默认路由字段
  static PreferredSizeWidget appBar(String title,{LeadingType leadingType = LeadingType.back, Function? leadingOnTap,Widget? customLeading, Widget? actionsChild,String? homeRouterStr = '/HomePage'}){
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: const Color(0xFFFFFFFF),
      title: Text(title,style: TextStyle(color: const Color(0xFF323233),fontSize: sp(36),fontFamily: "M"),),
      leading: ScetPlugin.getIsMiniProgramn()
          ? const Text('')
          : leading(
          leadingType,
          leadingOnTap:leadingOnTap,
          customLeading:customLeading,
          homeRouterStr:homeRouterStr
      ),
      actions: [
        actionsChild ?? Container()
      ],
    );
  }

  /// AppBar的返回按钮
  static Widget leading(LeadingType type,{Function? leadingOnTap,Widget? customLeading, String? homeRouterStr}){

    switch(type){

      case LeadingType.none : { return Container(); }

      case LeadingType.custom : { return customLeading!; }

      case LeadingType.back :
        {
          return InkWell(
            onTap: () {
              if(leadingOnTap != null){
                leadingOnTap.call();
              }else{
                Navigator.pop(navigatorKey.currentState!.overlay!.context);
              }
            },
            child: Container(
              width: px(40),
              height: px(40),
              alignment: Alignment.center,
              child: Image.asset('lib/assets/icons/other/back.png',fit: BoxFit.fill,width: px(40),height: px(40),),
            ),
          );
        }

      case LeadingType.home :
        {
          return InkWell(
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(navigatorKey.currentState!.overlay!.context, homeRouterStr!, (route) => false);
              leadingOnTap?.call();
            },
            child: Container(
              width: px(40),
              height: px(40),
              alignment: Alignment.center,
              child: Image.asset('lib/assets/icon/other/home.png',fit: BoxFit.fill,width: px(40),height: px(40),),
            ),
          );
        }
      default: return Container();
    }
  }

  ///表单卡片
  ///title：标题
  ///children：表单内容
  static Widget dataCard({String? title,required List<Widget> children,bool top = true,bool padding = true,int watermarkFontSize = 100, int watermarkCount = 1, Function? onTap}){
    return InkWell(
      child: Container(
        width: px(750),
        margin: EdgeInsets.only(top: top ? px(4):0),
        padding: padding ? EdgeInsets.all(px(16)) : EdgeInsets.all(px(0)),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: title?.isNotEmpty ?? false,
              child: Text(
                "$title",
                style: TextStyle(
                  color: Color(0xff323233),
                  fontSize: sp(28),
                  fontFamily: "M",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: px(10.0)),
              child: Column(
                  children: children
              ),
            )
          ],
        ),
      ),
      onTap: () => onTap?.call() ,
    );
  }

}

/// 定制的Appbar 返回按钮的类型
enum LeadingType {
  none,
  back,
  home,
  custom
}