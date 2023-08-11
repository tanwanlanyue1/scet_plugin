
// 需要检查的文件类型
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scet_plugin/components/toast_widget/toast_widget.dart';

enum PermissionType {
  storage(1, Permission.storage, '媒体和文件'),
  camera(2, Permission.camera, '拍照'),
  photos(3, Permission.photos , '图库'),
  phone(4, Permission.phone , '电话簿'),
  location(5, Permission.location , '位置'),
  manageExternalStorage(6, Permission.manageExternalStorage, '媒体和文件');

  const PermissionType(this.type, this.permission,this.value,);
  final int type;
  final Permission permission;
  final String value;


  static PermissionType getTypeByTitle(String title) => PermissionType.values.firstWhere((activity) => activity.name == title);
  static PermissionType getType(int number) => PermissionType.values.firstWhere((activity) => activity.type == number);
  static String getValue(int number) => PermissionType.values.firstWhere((activity) => activity.type == number).value;

}

// 权限管理的方法
class PermissionManage{

  /// 检查权限
  /// PermissionType 需要检查存在的权限列表
  /// 调用示例
  ///  bool checkPermission = await FileSystem.checkPermission([PermissionType.storage,]);
  ///  if(check){ 处理后续逻辑 }
  static Future<bool> checkPermission(List<PermissionType> permissionTypeList) async {
    if(!kIsWeb){
      for(int i = 0; i < permissionTypeList.length; i++){
        PermissionType item = permissionTypeList[i];
        PermissionStatus status = await item.permission.status;
        if (status != PermissionStatus.granted) {
          status = await Permission.storage.request();
          if (status != PermissionStatus.granted) {
            ToastWidget.showDialog(
                msg: '您未授权${item.value}权限，请先授权！',
                ok: () => openAppSettings(),
                okText: '去授权'
            );
            return false;
          }
        }
      }
    }
    return true;
  }
}