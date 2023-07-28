import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scet_plugin/tool/listView/un_listview.dart';
import 'package:scet_plugin/tool/screen/screen.dart';

/// 下拉选择器 支持 单选 多选操作
class DownInput extends StatefulWidget {
  final String? hitStr; //为空显示的文字
  final String? value;  //已选择内容后
  final String? dataKey;  //数据的key
  final List? data;     // 列表数据[{'name':标题}]
  final Map? currentData;//默认选中项（单选参数 或有id即可）
  final List? currentDataList;//默认选中项（多选参数 每项有id即可）
  final callback;     // 事件
  final beforeClick;  //点击返回前的点击处理
  final bool more;    // 是否开启多选状态 默认单选
  final bool readOnly;    // 是否开启只读
  final bool invert; // 是否开启反选

  const DownInput({Key? key,
    this.hitStr = '请选择内容',
    this.value,
    this.data,
    this.dataKey,
    this.currentData,
    this.currentDataList,
    this.callback,
    this.beforeClick,
    this.more = false,
    this.readOnly = false,
    this.invert = false,
  }) : super(key: key);

  @override
  _DownInputState createState() => _DownInputState();
}

class _DownInputState extends State<DownInput> {

  GlobalKey? _globalKey;
  String? _hitStr;//标题背景
  String? _value;//选择后显示
  String _dataKey = 'name';//数据的key
  List _data = []; //下拉数据
  bool _more = false;//true 多选 false 单选
  Map _currentData = {}; //单选时候的内容
  List _currentDataList = [];//多选时候的内容

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalKey = GlobalKey();
    _hitStr= widget.hitStr;
    _value= widget.value;
    _data = widget.data ?? [];
    _dataKey = widget.dataKey ?? _dataKey;
    _more = widget.more;
    _currentData = widget.currentData ?? _currentData;
    _currentDataList = widget.currentDataList ?? _currentDataList;
    onChange();
  }

  @override
  void didUpdateWidget(DownInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _hitStr= widget.hitStr;
    _value= widget.value;
    _data = widget.data ?? _data;
    _dataKey = widget.dataKey ?? _dataKey;
    _more = widget.more;
    _currentData = widget.currentData ?? _currentData;
    _currentDataList = widget.currentDataList ?? _currentDataList;
    onChange();
    setState(() {});
  }

  ///判断多选还是单选的回调操作
  setList(Map val){
    if(_more){  //多选
      if(_currentDataList.contains(val)) {
        _currentDataList.remove(val);
      }else if(_currentDataList.map((e) => e.containsKey('id') && e['id']==val['id']).contains(true)){
        for(int i = 0; i < _currentDataList.length; i++){
          if(_currentDataList[i]['id'] == val['id']){
            _currentDataList.removeAt(i);
          }
        }
      } else {
        _currentDataList.add(val);
      }
      widget.callback?.call(_currentDataList);
    } else { //单选
      if(_currentData.toString() == val.toString()
          || ( _currentData.containsKey('id')
              && _currentData['id'] == val['id'])
      ) {
        if(widget.invert){
          _currentData = {}; //下次重复点击 则清空已选择
          widget.callback?.call(null);
        }else{
          _currentData = val;//不清空已选
          widget.callback?.call(_currentData);
        }
      }else{
        _currentData = val;
        widget.callback?.call(_currentData);
      }
      Navigator.pop(context);
    }
    setState(() { });
  }

  void onChange(){
    if(_more){  //多选
      for(int i = 0; i < _currentDataList.length; i++){
        for (var item2 in _data) {
          if(_currentDataList[i].containsKey('id') && _currentDataList[i]['id'] == item2['id']){
            _currentDataList[i] = item2;
          }
        }
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _globalKey = null;
    _currentData = {};
    _currentDataList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, designSize: const Size(750.0, 1334.0),);
    return InkWell(
      child: Container(
        width: px(526.0),
        height: px(72.0),
        key: _globalKey,
        decoration: BoxDecoration(
          color: widget.readOnly ? Colors.transparent : Color(0XFFF5F6FA),
          // border: Border.all(width: px(1.0),color: Color(0X99A1A6B3)),
          borderRadius: BorderRadius.all(Radius.circular(px(4.0))),
        ),
        child: Row(
          children: [
            Expanded(
                child: ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    child:ListView(
                      padding: EdgeInsets.all(0),
                      scrollDirection:Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        Container(
                          height: px(56),
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: px(16.0)),
                          child: Text(
                            '${_value == null || _value == '' ? _hitStr : _value?.replaceAll("\n", " ")}',
                            style: TextStyle(
                                fontSize:sp(28.0),
                                color: _currentData.isEmpty && _currentDataList.isEmpty ? Color(0XFFA8ABB3) : Color(0XFF45474D)
                            ),
                          ),
                        ),
                      ],
                    )
                )
            ),
            !widget.readOnly?
            SizedBox(
              width: px(50.0),
              height: px(56.0),
              child: Icon(Icons.expand_more,color: Color(0xff8A8E99)),
            ):
            Container(),
          ],
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        if(widget.readOnly){
          return;
        }
        if(widget.beforeClick != null) {
          widget.beforeClick();
        }
        if(widget.value ==null ) {
          print('未设置value---->\nvalue：选中后的内容，设置为您变量中的参数\nhitStr:默认提示',);
        }
        if(_data.isEmpty ) {
          return;
        }
        RenderBox renderBox = _globalKey!.currentContext!.findRenderObject() as RenderBox;
        Rect box = renderBox.localToGlobal(Offset.zero) & renderBox.size;

        final _height = MediaQuery.of(context).size.height;

        final bottonDy = renderBox.localToGlobal(Offset(0.0, renderBox.size.height)).dy; //组件下方坐标

        final _count = _data.length >= 5 ? 5 : _data.length; // 下拉的高度

        /// 判断选择框是靠上还是靠下
        if((bottonDy +  (_count * px(58.0) + px(40))) > _height){
          box = Rect.fromLTRB(
              renderBox.localToGlobal(Offset.zero).dx,
              renderBox.localToGlobal(Offset.zero).dy - (_count * px(58.0) + px(40) + px(72)),
              box.right,
              box.bottom - (_count * px(58.0) + px(0)+ px(72)));
        }

        Navigator.push(
            context,
            DropDownMenuRoute(
                position: box, //位置
                callback:(val) { setList(val); },
                // menuHeight: px(500),//显示的高度自由调节
                data: _data, // 下拉数据
                more: _more, // 是否开启多选状态
                currentData: _currentData,
                dataKey: _dataKey,
                currentDataList: _currentDataList
            )
        );
      },
    );
  }
}
/// 获取位置
/// position：定位
/// menuHeight:渲染的高度
class DropDownMenuRouteLayout extends SingleChildLayoutDelegate {
  final Rect position;
  final double menuHeight;

  DropDownMenuRouteLayout({required this.position, required this.menuHeight});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // TODO: implement getConstraintsForChild
    return BoxConstraints.loose(
        Size(position.right - position.left, menuHeight));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // TODO: implement getPositionForChild
    return Offset(position.left, position.bottom);
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    return true;
  }
}

class DropDownMenuRoute extends PopupRoute {
  final Rect position; //出現的位置
  final double? menuHeight; //下拉顯示的高度 已设置默认 4*px（58）
  final List data; //数据
  final Map? currentData;//单选内容
  final List? currentDataList;//多选内容
  final bool more;//多选状态
  final String? dataKey;//数据key
  final callback;
  DropDownMenuRoute({
    required this.position,
    this.menuHeight,
    required this.data,
    this.currentData,
    this.currentDataList,
    this.dataKey,
    required this.more,
    this.callback
  });

  @override
  // TODO: implement barrierColor
  Color? get barrierColor => null;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => null;
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return CustomSingleChildLayout(
      delegate: DropDownMenuRouteLayout(
          position: position,
          menuHeight: menuHeight != null
              ? menuHeight!
              : data.length <= 5 ? data.length * px(58.0)+px(data.length) : 5 * px(58.0)+px(40)
      ),
      child: SizeTransition(
          axis : Axis.vertical,
          sizeFactor: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
          child:WindowsPop(
            data: data,
            callback:  callback,
            currentData: currentData,
            currentDataList: currentDataList,
            dataKey: dataKey,
            more: more,
          )
      ),
    );
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 300);
}

///下拉菜单样式
class WindowsPop extends StatefulWidget {
  final List data; //数据
  final Map? currentData;//单选内容
  final List? currentDataList;//多选内容
  final bool more;//多选状态
  final String? dataKey;//数据key
  final callback;
  const WindowsPop({Key? key,
    required this.data,
    this.currentData,
    this.dataKey,
    this.currentDataList,
    required this.more,
    this.callback
  }) : super(key: key);
  @override
  _WindowsPopState createState() => _WindowsPopState();
}

class _WindowsPopState extends State<WindowsPop> {

  List  _data = [];
  Map _currentData = {};
  List _currentDataList = [];
  bool _more = false;
  String _dataKey = 'name';

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    _dataKey = widget.dataKey ?? _dataKey;
    _currentData = widget.currentData ?? _currentData;
    _currentDataList = widget.currentDataList ?? _currentDataList;
    _more = widget.more;
  }
  @override
  void didUpdateWidget(WindowsPop oldWidget) {
    super.didUpdateWidget(oldWidget);
    _data = widget.data;
    _currentData = widget.currentData ?? _currentData;
    _currentDataList = widget.currentDataList ?? _currentDataList;
    _more = widget.more;
    _dataKey = widget.dataKey ?? _dataKey;
  }

  bool _bools(index) {
    bool _bo = false;
    if(_more) {
      if(_currentDataList.contains(_data[index])
          || _currentDataList.map((e) => e.containsKey('id') && e['id']==_data[index]['id']).contains(true)
      ) {
        _bo = true;
      }
    }else if(!_more && _currentData.toString() != '' && _currentData != {}){
      if( _currentData.toString() == _data[index].toString()
          || ( _currentData.containsKey('id') && _currentData['id'] == _data[index]['id'])
      ) {
        _bo = true;
      }
    }
    return _bo;
  }
  @override
  void dispose() {
    _currentData = {};
    _currentDataList = [];
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Color(0XFFFFFFFF),
            border: Border.all(width: px(1.5),color: Color(0X99A1A6B3)),
            borderRadius: BorderRadius.all(Radius.circular(px(4.0))),
          ),
          child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: ListView.builder(
                  itemCount: _data.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: Container(
                          height: px(58.0),
                          width: double.infinity,
                          padding: EdgeInsets.only(left: px(16.0)),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: px(1.0),color: Color(0X99A1A6B3))),
                              color: (_bools(index) ? Theme.of(context).primaryColor : Colors.transparent)
                          ),
                          child: ListView(
                            padding: EdgeInsets.all(0),
                            scrollDirection:Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            children: [
                              Container(
                                height: px(56),
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                // child:Text('${_data[index]['name']?.replaceAll("\n", " ")}',style: TextStyle(fontSize: sp(26.0),color: (_bools(index) ? Colors.white : Colors.black)),),
                                child:Text(_data[index][_dataKey] != null ?
                                '${_data[index][_dataKey]?.replaceAll("\n", " ")}':
                                '${_data[index]['title']?.replaceAll("\n", " ")}',
                                  style: TextStyle(fontSize: sp(26.0),color: (_bools(index) ? Colors.white : Colors.black)),),
                              ),
                            ],
                          )

                      ),
                      onTap: () {
                        widget.callback(_data[index]);
                        setState(() {});
                      },
                    );
                  }
              )
          )
      ),
    );
  }
}