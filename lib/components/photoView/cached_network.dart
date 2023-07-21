import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scet_plugin/tool/screen/screen.dart';

///缓存图片
///url: 图片地址
///fits: 是否充满
class CachedNetwork extends StatelessWidget {

  final String url;
  final BoxFit? fits;
  final int imgWidth;
  final Map<String, String>? httpHeaders;
  const CachedNetwork({Key? key,required this.url,this.fits,this.imgWidth = 150,this.httpHeaders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      httpHeaders: httpHeaders,
      imageUrl: '${url}',
      placeholder: (context, url) => const CircularProgressIndicator(),
      // placeholder: (context, url) => Center(child: Text('加载中...',style: TextStyle(color: Colors.blue,fontSize: sp(30)),),),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      // errorWidget: (context, url, error) => Image.network(url,fit: BoxFit.cover,),
      width:  px(imgWidth * 2),
      height: px(imgWidth * 2),
      memCacheHeight: 300,
      memCacheWidth: 300,
      maxWidthDiskCache: px(imgWidth * 2).toInt(),
      maxHeightDiskCache: px(imgWidth * 2).toInt(),
      fit: fits,
    );
  }
}
