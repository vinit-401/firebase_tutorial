import 'package:flutter/foundation.dart';

class Log{
  static void printLog(String value){
    if (kDebugMode) {
      //blue color
      print('\x1B[94m$value\x1B[0m');
    }
  }
}