import 'dart:typed_data';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scet_plugin/components/loading/loading.dart';
import 'package:scet_plugin/components/toast_widget/toast_widget.dart';
import 'package:http/http.dart' as http;

///保存图片
class SaveUtil {
  // isAsset本地图片   默认网络图片
  static Future<void> saveImage(String? imageUrl, {bool isAsset = false,Map<String, String>? httpHeaders}) async {
    try {
      if (imageUrl == null) {
        ToastWidget.showToastMsg('保存失败，图片地址不存在！');
      }
      // 权限检测
      PermissionStatus storageStatus = await Permission.storage.status;
      if (storageStatus != PermissionStatus.granted) {
        storageStatus = await Permission.storage.request();
        if (storageStatus != PermissionStatus.granted) {
          ToastWidget.showToastMsg('无法存储图片，请先授权！');
        }
      }
      BotToast.showCustomLoading(
          ignoreContentClick: true,
          toastBuilder: (cancelFunc) {
            return Loading(cancelFunc: cancelFunc);
          }
      );
      // 保存的图片数据
      Uint8List imageBytes;
      if (isAsset == true) {
        ByteData bytes = await rootBundle.load(imageUrl!);
        imageBytes = bytes.buffer.asUint8List();
      } else {
        // 保存网络图片
        // imageBytes = await Request().getbytes(imageUrl);
        Map<String, String>? headers = httpHeaders;
        imageBytes = await getData(imageUrl!, headers: headers);
      }

      // 保存图片
      final result = await ImageGallerySaver.saveImage(imageBytes);
      if (result['isSuccess']) {
        ToastWidget.showToastMsg('保存图片成功！');
      } else {
        ToastWidget.showToastMsg('保存图片失败！');
      }
      BotToast.closeAllLoading();
    } catch (e) {
      print(e.toString());
      BotToast.closeAllLoading();
    }
  }
}
//使用 http包获取文件流
Future<Uint8List> getData(String url, {Map<String, String>? headers}) async {
  // 创建一个新的 HTTP 请求对象
  var request = http.Request('GET', Uri.parse(url));

  // 检查是否提供了请求头，并将其添加到请求中
  if (headers != null) {
    for (var header in headers.entries) {
      request.headers[header.key] = header.value;
    }
  }

  // 发送 HTTP 请求
  var response = await request.send();

  // 检查请求是否成功
  if (response.statusCode == 200) {
    return await response.stream.toBytes(); // 将响应数据转换为 bytes 类型
  } else {
    throw Exception('Failed to get data');
  }
}
