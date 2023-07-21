import 'package:date_format/date_format.dart';

class ScetTime{
  ///日期转换
  static String formatTime(time) {
    if(null == time){
      return '-';
    }
    return utcToLocal(time.toString()).substring(0,16);
  }

  ///时间转换
  static String utcToLocal(String? time,) {
    if(null == time){
      return '-';
    }
    return formatDate(DateTime.parse(time).toLocal() ,[yyyy,'/',mm,'/',dd, ' ',HH,':',nn,':',ss]);
  }

  ///时间转换
  static  String utcToTime(String? time,{bool haveHN = true}) {
    if(null == time){
      return '-';
    }
    if(!haveHN){
      return formatDate(DateTime.parse(time).toLocal() ,[yyyy,'-',mm,'-',dd]);
    } else {
      return formatDate(DateTime.parse(time).toLocal() ,[yyyy,'-',mm,'-',dd, ' ',HH,':',nn]);
    }
  }

  ///时间转换
  static String utcToTime2(String? time,{bool haveHN = true}) {
    if(null == time){
      return '-';
    }
    if(!haveHN){
      return formatDate(DateTime.parse(time).toLocal() ,[mm,'-',dd]);
    } else {
      return formatDate(DateTime.parse(time).toLocal() ,[mm,'-',dd, ' ',HH,':',nn]);
    }
  }

  ///时间转换 年，月，日
  static String utcTransition() {
    String now = formatDate(DateTime.parse(DateTime.now().toString()).toLocal() ,[yyyy,'',mm,'',dd,])+'/';
    return now;
  }

  ///危废时间转换
  static String wfUtcToLocal(String? time) {
    if(null == time){
      return '-';
    }
    return formatDate(DateTime.parse(time).toLocal() ,[yyyy,'-',mm,'-',dd, ' ',HH,':',nn,':',ss]);
  }
}