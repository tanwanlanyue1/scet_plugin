import 'dart:convert';

/// appId : "wx71d185d302ce0bc8"
/// timestamp : "1690855964"
/// nonceStr : "scetzlx"
/// signature : "7df935bdf99f94294df9d2d0438c73fb35f1a75f"
/// jsApiList : ["onHistoryBack","scanQRCode","invoke","updateAppMessageShareData","updateTimelineShareData","onMenuShareTimeline","onMenuShareAppMessage","onMenuShareQQ","onMenuShareWeibo","onMenuShareQZone","startRecord","stopRecord","onVoiceRecordEnd","playVoice","pauseVoice","stopVoice","onVoicePlayEnd","uploadVoice","downloadVoice","chooseImage","previewImage","uploadImage","downloadImage","translateVoice","getNetworkType","openLocation","getLocation","hideOptionMenu","showOptionMenu","hideMenuItems","showMenuItems","hideAllNonBaseMenuItem","showAllNonBaseMenuItem","closeWindow","scanQRCode","chooseWXPay","openProductSpecificView","addCard","chooseCard","openCard"]

WxConfigData wxConfigDataFromJson(String str) => WxConfigData.fromJson(json.decode(str));
String wxConfigDataToJson(WxConfigData data) => json.encode(data.toJson());
class WxConfigData {
  WxConfigData({
      this.appId, 
      this.timestamp, 
      this.nonceStr, 
      this.signature, 
      this.jsApiList,});

  WxConfigData.fromJson(dynamic json) {
    appId = json['appId'];
    timestamp = json['timestamp'];
    nonceStr = json['nonceStr'];
    signature = json['signature'];
    jsApiList = json['jsApiList'] != null ? json['jsApiList'].cast<String>() : [];
  }
  String? appId;
  num? timestamp;
  String? nonceStr;
  String? signature;
  List<String>? jsApiList;
WxConfigData copyWith({  String? appId,
  num? timestamp,
  String? nonceStr,
  String? signature,
  List<String>? jsApiList,
}) => WxConfigData(  appId: appId ?? this.appId,
  timestamp: timestamp ?? this.timestamp,
  nonceStr: nonceStr ?? this.nonceStr,
  signature: signature ?? this.signature,
  jsApiList: jsApiList ?? this.jsApiList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appId'] = appId;
    map['timestamp'] = timestamp;
    map['nonceStr'] = nonceStr;
    map['signature'] = signature;
    map['jsApiList'] = jsApiList;
    return map;
  }

}