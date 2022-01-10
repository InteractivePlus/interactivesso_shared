import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:characters/characters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'regexpserializer.dart';

part 'validator.g.dart';

abstract class TypeValidator<T> implements Serializable<Map<String,dynamic>>{
  final String typeOfTypeValidator;

  bool validate(T data);
  bool validateDynamic(dynamic data){
    if(data is! T){
      return false;
    }
    return validate(data);
  }

  bool validateNullableDynamic(dynamic data){
    if(data == null){
      return true;
    }else{
      return validateDynamic(data);
    }
  }

  Map<String,dynamic> _serialize();

  @override
  Map<String,dynamic> serialize([String? locale]){
    Map<String,dynamic> serialized = _serialize();
    serialized['type_of_validator'] = typeOfTypeValidator;
    return serialized;
  }

  @override
  Map<String, dynamic> toJson() => serialize(null);


  const TypeValidator(this.typeOfTypeValidator);
  static TypeValidator fromMap(Map<String,dynamic> map){
    if(map['type_of_validator'] == null || map['type_of_validator'] is! String){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    switch(map['type_of_validator'] as String){
      case MapValidator.TYPE_VALIDATOR:
        return MapValidator.fromMap(map);
      case DoubleRangeValidator.TYPE_VALIDATOR:
        return DoubleRangeValidator.fromMap(map);
      case IntRangeValidator.TYPE_VALIDATOR:
        return IntRangeValidator.fromMap(map);
      case StringRegexValidator.TYPE_VALIDATOR:
        return StringRegexValidator.fromMap(map);
      case HexStringValidator.TYPE_VALIDATOR:
        return HexStringValidator.fromMap(map);
      case AnyOfValidator.TYPE_VALIDATOR:
        return AnyOfValidator.fromMap(map);
      case ConstantStringValidator.TYPE_VALIDATOR:
        return ConstantStringValidator.fromMap(map);
      default:
        throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
  }
  static TypeValidator fromJson(Map<String,dynamic> json) => fromMap(json);
}

class TypeValidatorJsonConverter implements JsonConverter<TypeValidator, Map<String,dynamic>>{
  const TypeValidatorJsonConverter();
  @override
  TypeValidator fromJson(Map<String, dynamic> json) {
    return TypeValidator.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(TypeValidator object) {
    return object.toJson();
  }
}

class TypeValidatorStringJsonConverter implements JsonConverter<TypeValidator<String>, Map<String,dynamic>>{
  const TypeValidatorStringJsonConverter();
  @override
  TypeValidator<String> fromJson(Map<String, dynamic> json) {
    return TypeValidator.fromJson(json) as TypeValidator<String>;
  }

  @override
  Map<String, dynamic> toJson(TypeValidator<String> object) {
    return object.toJson();
  }
}

@JsonSerializable(includeIfNull: false)
class MapValidatorValue implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'nullable')
  final bool isNullable;

  @TypeValidatorJsonConverter()
  @JsonKey(required: true, name: 'validator')
  final TypeValidator<dynamic> validator;

  @override
  Map<String, dynamic> serialize([String? locale]) => _$MapValidatorValueToJson(this);

  @override
  Map<String, dynamic> toJson()  => serialize(null);

  MapValidatorValue({required this.validator, this.isNullable = false});
  factory MapValidatorValue.fromMap(Map<String,dynamic> map) => _$MapValidatorValueFromJson(map);
  static MapValidatorValue fromJson(Map<String,dynamic> json) => MapValidatorValue.fromMap(json);
}

@JsonSerializable(includeIfNull: false)
class MapValidator extends TypeValidator<Map<String,dynamic>>{
  static const String TYPE_VALIDATOR = 'MapValidator';

  @JsonKey(required: true, name: 'key_validator_map')
  final Map<String, MapValidatorValue> keyAndValidatorMap;

  @override
  bool validate(Map<String, dynamic> data) {
    for(MapEntry<String,MapValidatorValue> validatorMapEntry in keyAndValidatorMap.entries){
      dynamic dataAtKey = data[validatorMapEntry.key];
      if(dataAtKey == null){
        if(!validatorMapEntry.value.isNullable){
          return false;
        }
      }else{
        if(!validatorMapEntry.value.validator.validateDynamic(dataAtKey)){
          return false;
        }
      }
    }
    return true;
  }

  @override
  Map<String, dynamic> _serialize() => _$MapValidatorToJson(this);

  MapValidator({required this.keyAndValidatorMap}) : super(TYPE_VALIDATOR);
  factory MapValidator.fromMap(Map<String,dynamic> map) => _$MapValidatorFromJson(map);
  static MapValidator fromJson(Map<String,dynamic> json) => MapValidator.fromMap(json);
}

@JsonSerializable(includeIfNull: false)
class DoubleRangeValidator extends TypeValidator<double>{
  static const String TYPE_VALIDATOR = 'DoubleRangeValidator';

  @JsonKey(name: 'min')
  final double? min;
  
  @JsonKey(name: 'max')
  final double? max;

  @override
  bool validate(double data) {
    if(min != null && data < min!){
      return false;
    }
    if(max != null && data > max!){
      return false;
    }
    return true;
  }

  @override
  Map<String, dynamic> _serialize() => _$DoubleRangeValidatorToJson(this);

  const DoubleRangeValidator({this.min, this.max}) : super(TYPE_VALIDATOR);
  factory DoubleRangeValidator.fromMap(Map<String,dynamic> map) => _$DoubleRangeValidatorFromJson(map);
  static DoubleRangeValidator fromJson(Map<String,dynamic> json) => DoubleRangeValidator.fromMap(json);
}

@JsonSerializable(includeIfNull: false)
class IntRangeValidator extends TypeValidator<int>{
  static const String TYPE_VALIDATOR = 'IntRangeValidator';

  @JsonKey(name: 'min')
  final int? min;

  @JsonKey(name: 'max')
  final int? max;

  @override
  bool validate(int data) {
    if(min != null && data < min!){
      return false;
    }
    if(max != null && data > max!){
      return false;
    }
    return true;
  }

  @override
  Map<String, dynamic> _serialize() => _$IntRangeValidatorToJson(this);

  const IntRangeValidator({this.min, this.max}) : super(TYPE_VALIDATOR);
  factory IntRangeValidator.fromMap(Map<String,dynamic> map) => _$IntRangeValidatorFromJson(map);
  static IntRangeValidator fromJson(Map<String,dynamic> json) => IntRangeValidator.fromMap(json);
}

@JsonSerializable(includeIfNull: false)
class StringRegexValidator extends TypeValidator<String>{
  static const String TYPE_VALIDATOR = 'StringRegexValidator';

  @NullableRegExpSerializer()
  @JsonKey(name: 'reg_exp')
  final RegExp? regExp;

  @JsonKey(name: 'min_bytes')
  final int? minBytes;

  @JsonKey(name: 'max_bytes')
  final int? maxBytes;

  @JsonKey(name: 'min_chars')
  final int? minChars;

  @JsonKey(name: 'max_chars')
  final int? maxChars;

  @override
  bool validate(String data) {
    if(minChars != null || maxChars != null){
      int charLength = data.characters.length;
      if(minChars != null && charLength < minChars!){
        return false;
      }
      if(maxChars != null && charLength > maxChars!){
        return false;
      }
    }
    if(minBytes != null || maxBytes != null){
      int byteLength = data.length;
      if(minBytes != null && byteLength < minBytes!){
        return false;
      }
      if(maxBytes != null && byteLength > maxBytes!){
        return false;
      }
    }
    if(regExp != null && !(regExp!.hasMatch(data))){
      return false;
    }
    return true;
  }

  @override
  Map<String, dynamic> _serialize() => _$StringRegexValidatorToJson(this);

  StringRegexValidator({this.regExp, this.minBytes, this.maxBytes, this.minChars, this.maxChars}) : super(TYPE_VALIDATOR);
  factory StringRegexValidator.fromMap(Map<String,dynamic> map) => _$StringRegexValidatorFromJson(map);
  static StringRegexValidator fromJson(Map<String,dynamic> json) => StringRegexValidator.fromMap(json);  
}

@JsonSerializable(includeIfNull: false)
class HexStringValidator extends TypeValidator<String>{
  static const String TYPE_VALIDATOR = 'HexStringValidator';

  @JsonKey(name: 'min')
  final int? minLen;

  @JsonKey(name: 'max')
  final int? maxLen;

  @override
  bool validate(String data) {
    if(minLen != null && data.length < minLen!){
      return false;
    }
    if(maxLen != null && data.length > maxLen!){
      return false;
    }
    return data.isValidHexString();
  }

  @override
  Map<String, dynamic> _serialize() => _$HexStringValidatorToJson(this);

  const HexStringValidator({this.minLen, this.maxLen}) : super(TYPE_VALIDATOR);
  factory HexStringValidator.fromMap(Map<String,dynamic> map) => _$HexStringValidatorFromJson(map);
  static HexStringValidator fromJson(Map<String,dynamic> json) => HexStringValidator.fromMap(json);
}

@JsonSerializable(includeIfNull: false)
class AnyOfValidator extends TypeValidator<dynamic>{
  static const String TYPE_VALIDATOR = "AnyOfValidator";

  @TypeValidatorJsonConverter()
  @JsonKey(required: true, name: 'types')
  final List<TypeValidator<dynamic>> types;

  @override
  bool validate(dynamic data){
    if(data == null){
      return false;
    }
    for(TypeValidator v in types){
      if(v.validateDynamic(data)){
        return true;
      }
    }
    return false;
  }

  @override
  Map<String, dynamic> _serialize() => _$AnyOfValidatorToJson(this);

  AnyOfValidator({required this.types}) : super(TYPE_VALIDATOR);
  factory AnyOfValidator.fromMap(Map<String,dynamic> map) => _$AnyOfValidatorFromJson(map);
  static AnyOfValidator fromJson(Map<String,dynamic> json) => AnyOfValidator.fromMap(json);
}

@JsonSerializable(includeIfNull: false)
class ConstantStringValidator extends TypeValidator<String>{
  static const String TYPE_VALIDATOR = "ConstantStringValidator";

  @TypeValidatorJsonConverter()
  @JsonKey(required: true, name: 'types')
  final List<String> constants;

  @override
  bool validate(String data){
    return constants.contains(data);
  }

  @override
  Map<String, dynamic> _serialize() => _$ConstantStringValidatorToJson(this);

  ConstantStringValidator({required this.constants}) : super(TYPE_VALIDATOR);
  factory ConstantStringValidator.fromMap(Map<String,dynamic> map) => _$ConstantStringValidatorFromJson(map);
  static ConstantStringValidator fromJson(Map<String,dynamic> json) => ConstantStringValidator.fromMap(json);
}