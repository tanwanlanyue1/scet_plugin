import 'dart:async';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:scet_plugin/components/noData/no_data.dart';
import 'package:scet_plugin/scet_ui/easyRefresh/easy_refreshs.dart';

/// 自定义下拉刷新
/// 显示样式分 slivers 和 itemBuilder 两种
/// 1. slivers ： 组合复杂布局 使用 slivers 数组自定义样式 已经循环
/// 例子
///    slivers: <Widget>[
///           SliverList(
///             delegate: SliverChildBuilderDelegate((context, index) {
///               return taskDetail(item: EnforceDetail);},
///                 childCount: 1),
///           ),
///           SliverList(
///               Map item = _pageList[index];
///               return  itemCard(
///                     item: item,
///                     index:index
///                 );},
///                 childCount: _pageList.length),
///           ),
///         ],
///
/// 2. itemBuilder 内置了Listview 循环 只需要传递循环体本身的每一项
/// 例子
///   itemBuilder: (context, index) {
///           Map item = _pageList[index];
///           return itemCard(
///               item: item,
///               index:index
///           );
///         },
class CustomEasyRefresher extends StatefulWidget {
  // 页面列表数据
  final List pageList;

  // EasyRefreshController实例，用于控制刷新和加载的状态
  final EasyRefreshController? easyRefreshController;

  // 加载回调函数
  final FutureOr<dynamic> Function()? onLoad;

  // 刷新回调函数
  final FutureOr<dynamic> Function()? onRefresh;

  // 自动默认下拉刷新 首次刷新
  final bool refreshOnStart;

  // 指示器的位置，默认为上方
  final IndicatorPosition indicatorPosition;

  // 构建子组件的回调函数
  final Widget Function(BuildContext context, int index)? itemBuilder;

  // 原来下来刷新中可添加多种样式的列表
  final List<Widget>? slivers;

  final String noDataStr;

  const CustomEasyRefresher({
    required this.pageList,
    required this.easyRefreshController,
    this.onLoad,
    this.onRefresh,
    this.indicatorPosition = IndicatorPosition.above,
    this.refreshOnStart = true,
    this.itemBuilder,
    this.slivers,
    this.noDataStr = '暂无数据!',
    Key? key
  }) : super(key: key);

  @override
  State<CustomEasyRefresher> createState() => _CustomEasyRefresherState();
}

class _CustomEasyRefresherState extends State<CustomEasyRefresher> {
  @override
  Widget build(BuildContext context) {
    return  widget.slivers != null ? _easyRefresh() :  _easyRefreshBuild();
  }

  /// 普通构造
  EasyRefresh _easyRefresh(){
    List<Widget> slivers = List<Widget>.from(widget.slivers!);
    if(widget.pageList.isEmpty){
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return noData();
        },
          childCount: 1,
        ),
      ));
    }
    return EasyRefresh(
      // 指定刷新时的头部组件
      header: headers(),
      // 指定加载时的底部组件
      footer: footers(),
      // 加载回调函数
      onLoad: () async {
        await widget.onLoad?.call();
        setState(() {});
      },
      // 刷新回调函数
      onRefresh: () async {
        await widget.onRefresh?.call();
        setState(() {});
      },
      refreshOnStart: widget.refreshOnStart,
      // 刷新完成后重置刷新状态
      resetAfterRefresh: true,
      simultaneously: true,
      controller: widget.easyRefreshController,
      child: CustomScrollView(
        slivers: slivers
      ),
    );
  }

  /// 改装后的封装
  EasyRefresh _easyRefreshBuild(){

    return EasyRefresh.builder(
      // 在开始刷新时立即触发刷新
      refreshOnStart: widget.refreshOnStart,
      // 刷新完成后重置刷新状态
      resetAfterRefresh: true,
      // 同时触发刷新和加载的回调函数
      simultaneously: true,
      // 加载回调函数
      onLoad: () async {
        await widget.onLoad?.call();
        setState(() {});
      },
      // 刷新回调函数
      onRefresh: () async {
        await widget.onRefresh?.call();
        setState(() {});
      },
      // 指定刷新时的头部组件
      header: headers(),
      // 指定加载时的底部组件
      footer: footers(),
      controller: widget.easyRefreshController,
      childBuilder: widget.pageList.isEmpty ? noDataList :  (context, physics) {
        return ListView.builder(
          physics: physics,
          itemCount: widget.pageList.length,
          itemBuilder: widget.itemBuilder!,
        );
      },
    );
  }

  Widget noDataList (context, physics) {
    return ListView(
      physics: physics,
      children: [ noData() ],
    );
  }

  Widget noData () {
   return NoData(timeType: true, state: widget.noDataStr);
  }
}
