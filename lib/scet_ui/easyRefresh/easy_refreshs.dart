import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

/// 页面状态（新）
enum RefreshType {
  onRefresh, // 刷新
  onLoad // 加载
}

/// 页面状态 (旧)
enum typeStatusEnum {
  onRefresh, // 刷新
  onLoad // 加载
}

Header headers(){
  return const ClassicHeader(
    hitOver: true,
    safeArea: true,
    processedDuration: Duration(milliseconds: 100),
    showMessage: true,
    showText: true,
    // position: news.IndicatorPosition.above,
    // 下面是一些文本配置
    processingText: "正在刷新...",
    readyText: "正在刷新...",
    armedText: "释放以刷新",
    dragText: "下拉刷新",
    processedText: "刷新成功",
    failedText: "刷新失败",
    messageText: "更新于 %T",
    messageStyle: TextStyle(color:  Colors.teal)
  );
}

Footer footers(){
  return const ClassicFooter(
    processedDuration: Duration(milliseconds: 100),
    showMessage: true,
    showText: true,
    safeArea: true,
    // position: widget.indicatorPosition,
    // 下面是一些文本配置
    processingText: "加载中...",
    processedText: "加载成功",
    readyText: "加载中...",
    armedText: "释放以加载更多",
    dragText: "上拉加载",
    failedText: "加载失败",
    noMoreText: "没有更多数据啦",
    messageText: "更新于 %T",
    messageStyle: TextStyle(color:  Colors.teal),
    noMoreIcon: Icon(Icons.warning_amber_outlined)
  );
}