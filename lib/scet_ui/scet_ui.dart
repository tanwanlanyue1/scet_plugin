import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child: Image.asset('images/back.png', package: 'scet_plugin',fit: BoxFit.fill,width: px(40),height: px(40),),
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
                // child: Image(image: const AssetImage('assets/icons/other/home.png', package: ''),fit: BoxFit.fill,width: px(40),height: px(40))
              child: Image.asset('images/home.png', package: 'scet_plugin',fit: BoxFit.fill,width: px(40),height: px(40),),
            )
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

  ///表格行项目
  ///titleColor:标题颜色
  ///title:标题
  ///alignStart:居上
  static Widget rowItem({
    Color? titleColor,
    bool alignStart = false,
    bool padding = true,
    bool expanded = true,
    bool expandedLeft = false,
    String? title,
    required Widget child,
    Widget? childBottom,
  }) {
    return Padding(
        padding: padding ? EdgeInsets.only(top: px(12),bottom: px(12)) : EdgeInsets.zero,
        child: Column(
          children: [
            Row(
                crossAxisAlignment: alignStart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: expandedLeft,
                    child: Expanded(
                      child: SizedBox(
                          child: Text(
                              '$title',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: titleColor ?? Color(0XFF969799),
                                  fontSize: sp(28.0),
                                  fontWeight: FontWeight.w500
                              )
                          )
                      ),
                    ),
                    replacement: SizedBox(
                        width: px(150),
                        child: Text(
                            '$title',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: titleColor ?? Color(0XFF969799),
                                fontSize: sp(28.0),
                                fontWeight: FontWeight.w500
                            )
                        )
                    ),
                  ),
                  expanded ? Expanded(child: child) : child
                ]
            ),
            if(childBottom != null)childBottom
          ],
        )
    );
  }

  ///输入框
  ///disabled:启用
  ///filled:填充的背景色
  ///hintText:默认
  ///onChanged:回调
  ///chat_unit:单位
  ///TextInputType 键盘类型
  static Widget inputWidget({String value = '', bool? disabled, bool filled = true, String? hintText = '请输入', Function? onChanged,int lines = 1, String? unit,TextInputType? keyboardType,bool number = false }) {
    final TextEditingController _inputWidgetController = TextEditingController();
    _inputWidgetController.text = value;
    return Row(
      children: [
        Expanded(
          child: TextFormField(
              enabled: disabled,
              controller: _inputWidgetController,
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: '$hintText',
                hintStyle: TextStyle(
                    color: Color(0XFFB0B2B8),
                    fontSize: sp(28.0)
                ),
                contentPadding: EdgeInsets.all(px(16.0)),
                filled: filled,
                fillColor: Color(0XFFF5F6FA),
                border: InputBorder.none,
              ),
              maxLines: lines,
              onChanged: (val){
                onChanged?.call(val);
              },
              inputFormatters: number ? [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),//数字包括小数
              ] : null,
              keyboardType: keyboardType ?? TextInputType.text,
              style: TextStyle(
                color: Color(0XFF2E2F33),
                fontSize: sp(28.0),
              )
          ),
        ),
        if(unit != null)Text(
          unit,style: TextStyle( fontSize: sp(28.0)),
        )
      ],
    );
  }

  ///提交按钮
  ///cancel:取消回调
  ///submit:提交回调
  ///canColors:取消背景色
  ///subColors:提交背景色
  ///subTextColor:提交文字颜色
  ///subfill:提交背景色是否填充
  static Widget submit({Function? cancel,Function? submit,Function? submit2,String? cancels,String? submits,String? submits2,Color? subTextColor,Color? canColors,Color? subColors,Color? subColors2,double? textHeight,double? textWidth,bool subfill = false}){
    return Container(
      height: px(88),
      margin: EdgeInsets.only(top: px(4)),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              width: px(textWidth ?? 240),
              height: px(textHeight ?? 56),
              alignment: Alignment.center,
              child: Text(
                cancels ?? '取消',
                style: TextStyle(
                    fontSize: sp(24),
                    fontFamily: "R",
                    color: canColors ?? Color(0xFF323233)),
              ),
              decoration: BoxDecoration(
                border: Border.all(width: px(2),color: canColors ?? Color(0XffE8E8E8)),
                borderRadius: BorderRadius.all(Radius.circular(px(28))),
              ),
            ),
            onTap: (){
              cancel?.call();
            },
          ),
          if(submit != null) GestureDetector(
            child: Container(
              width: px(textWidth ?? 240),
              height: px(textHeight ?? 56),
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: px(24)),
              child: Text(
                submits ?? '提交',
                style: TextStyle(
                    fontSize: sp(24),
                    fontFamily: "R",
                    color: subTextColor ?? Colors.white),
              ),
              decoration: BoxDecoration(
                color: subfill ? (subColors ?? Color(0xff4D7FFF)) : Colors.transparent,
                border: Border.all(width: px(2),color: subColors ?? Color(0XffE8E8E8)),
                borderRadius: BorderRadius.all(Radius.circular(px(28))),
              ),
            ),
            onTap: (){
              submit.call();
            },
          ),
          if(submit2 != null) GestureDetector(
            child: Container(
              width: px(textWidth ?? 240),
              height: px(textHeight ?? 56),
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: px(24)),
              child: Text(
                submits2 ?? '提交',
                style: TextStyle(
                    fontSize: sp(24),
                    fontFamily: "R",
                    color: subTextColor ?? Colors.white),
              ),
              decoration: BoxDecoration(
                color: subfill ? (subColors2 ?? Color(0xff4D7FFF)) : Colors.transparent,
                border: Border.all(width: px(2),color: subColors2 ?? Color(0XffE8E8E8)),
                borderRadius: BorderRadius.all(Radius.circular(px(28))),
              ),
            ),
            onTap: (){
              submit2.call();
            },
          ),
        ],
      ),
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


/// 枚举页面类型
/// add, 新增模式
/// edit, 编辑模式
/// details, // 详情显示模式
enum PageType {
  add(1, '新增模式'),
  edit(2, '编辑模式'),
  details(3, '编辑模式'),
  custom(4, '自定义模式');

  const PageType(this.type,this.value,);
  final int type;
  final String value;

  static PageType getTypeByTitle(String title) => PageType.values.firstWhere((activity) => activity.value == title);
  static PageType getType(int number) => PageType.values.firstWhere((activity) => activity.type == number);
  static String getValue(int number) => PageType.values.firstWhere((activity) => activity.type == number).value;
}