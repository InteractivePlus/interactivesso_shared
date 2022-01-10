import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../util/validator.dart';

part 'appsystem.g.dart';

@JsonSerializable()
@TypeValidatorStringJsonConverter()
class AppSystemValidators implements Serializable<Map<String,dynamic>>{
  final TypeValidator<String> appDisplayNameValidator;
  
  final TypeValidator<String> appDescriptionValidator;

  final TypeValidator<String> appGroupIdValidator;

  final TypeValidator<String> appGroupDisplayNameValidator;

  final TypeValidator<String> appGroupDescriptionValidator;

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