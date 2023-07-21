import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:scet_plugin/components/photoView/save_util.dart';
import 'package:scet_plugin/tool/screen/screen.dart';

// ignore: must_be_immutable
///画廊
///images: 图片数组
///index: 图片下标
///heroTag: 图片标签
///controller: 控制器
///imgType: 图片类型 http ：默认，网址  asset： 包
///httpHeaders: {}可以传headers
class PhotoViewGalleryScreen extends StatefulWidget {
  List images = [];//格式['','']
  int index = 0;
  String? heroTag;
  PageController? controller;
  String? imgType;
  final Map<String, String>? httpHeaders;
  PhotoViewGalleryScreen({
    Key? key,
    required this.images,
    required this.index,
    this.controller,
    this.heroTag,
    this.imgType = 'http',
    this.httpHeaders
  }) : super(key: key){
    controller=PageController(initialPage: index);
  }

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen> {
  int currentIndex = 0;//下标

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return widget.imgType == 'http' ? PhotoViewGalleryPageOptions(
                  imageProvider:  CachedNetworkImageProvider(
                    widget.images[index],
                    headers: widget.httpHeaders,
                  )
                //   // heroAttributes: (widget.heroTag?.isNotEmpty ?? false) ? PhotoViewHeroAttributes(tag: widget.heroTag!):null,
                ):  PhotoViewGalleryPageOptions(imageProvider: AssetImage(widget.images[index]));
              },
              itemCount: widget.images.length,
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
              ),
              backgroundDecoration: null,
              pageController: widget.controller,
              enableRotation: true,
              onPageChanged: (index){
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          // 图片index显示
          Positioned(
            top: MediaQuery.of(context).padding.top+15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex+1}/${widget.images.length}",style: const TextStyle(color: Colors.white,fontSize: 16)),
            ),
          ),
          // 右上角关闭按钮
          Positioned(
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: const Icon(Icons.close,size: 30,color: Colors.white,),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          // 右下角下载按钮
          Positioned(
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom+20,
            child: IconButton(
              icon: const Icon(Icons.file_download,size: 30,color: Colors.white,),
              onPressed: () async {
                var status = await Permission.photos.status;
                if (status.isDenied) {
                  _showDialog();
                }
                // 保存照片
                SaveUtil.saveImage(
                    widget.images[widget.index],
                    isAsset:  widget.imgType == 'asset' ? true : false,
                    httpHeaders: widget.httpHeaders
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("温馨提示",style: TextStyle(fontSize:sp(30) ),),
        content: Text("您当前没有开启相册权限",style: TextStyle(fontSize:sp(25)),),
        actions: <Widget>[
          TextButton(
            onPressed: () {openAppSettings();},
            child: const Text("去开启"),
          ),
          TextButton(
            onPressed: () {Navigator.of(context).pop();},
            child: const Text("取消"),
          ),
        ],
      );
    });
    return;
  }
}