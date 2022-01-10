import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_shared/interactivesso_shared.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appsystem.g.dart';

@JsonSerializable()
@TypeValidatorJsonConverter()
class AppSystemValidators implements Serializable<Map<String,dynamic>>{
  final TypeValidator appDisplayNameValidator;
  
  final TypeValidator appDescriptionValidator;

  final TypeValidator appGroupIdValidator;

  final TypeValidator appGroupDisplayNameValidator;

  final TypeValidator appGroupDescriptionValidator;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$AppSystemValidatorsToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  AppSystemValidators({
    required this.appDisplayNameValidator,
    required this.appDescriptionValidator,
    required this.appGroupIdValidator,
    required this.appGroupDisplayNameValidator,
    required this.appGroupDescriptionValidator
  });

  factory AppSystemValidators.fromMap(Map<String,dynamic> map) => _$AppSystemValidatorsFromJson(map);
  static AppSystemValidators fromJson(Map<String,dynamic> json) => AppSystemValidators.fromMap(json);
}