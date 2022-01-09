import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:json_annotation/json_annotation.dart';

class RegExpSerializer implements JsonConverter<RegExp,Map<String,dynamic>>{
  const RegExpSerializer();
  @override
  RegExp fromJson(Map<String,dynamic> json) {
    bool multiLine = false;
    bool caseSensitive = true;
    bool unicode = false;
    bool dotAll = false;
    late String source;

    if(json['source'] == null || json['source'] is! String){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }else{
      source = json['source'];
    }
    if(json['multi_line'] != null && json['multi_line'] is bool){
      multiLine = json['multi_line'];
    }
    if(json['case_sensitive'] != null && json['case_sensitive'] is bool){
      caseSensitive = json['case_sensitive'];
    }
    if(json['unicode'] != null && json['unicode'] is bool){
      unicode = json['unicode'];
    }
    if(json['dot_all'] != null && json['dot_all'] is bool){
      dotAll = json['dot_all'];
    }
    return RegExp(source,multiLine: multiLine, caseSensitive: caseSensitive, unicode: unicode, dotAll: dotAll);
  }

  @override
  Map<String,dynamic> toJson(RegExp object) {
    Map<String,dynamic> returnMap = {
      'source': object.pattern
    };
    if(object.isMultiLine){
      returnMap['multi_line'] = object.isMultiLine;
    }
    if(!object.isCaseSensitive){
      returnMap['case_sensitive'] = object.isCaseSensitive;
    }
    if(object.isUnicode){
      returnMap['unicode'] = object.isUnicode;
    }
    if(object.isDotAll){
      returnMap['dot_all'] = object.isDotAll;
    }
    return returnMap;
  }
}

class NullableRegExpSerializer implements JsonConverter<RegExp?,Map<String,dynamic>?>{
  const NullableRegExpSerializer();
  static const RegExpSerializer serializer = RegExpSerializer();

  @override
  RegExp? fromJson(Map<String, dynamic>? json) {
    if(json == null){
      return null;
    }
    return serializer.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RegExp? object) {
    if(object == null){
      return null;
    }
    return serializer.toJson(object);
  }
}