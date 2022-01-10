import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_shared/interactivesso_shared.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usersystem.g.dart';

@JsonSerializable()
@TypeValidatorJsonConverter()
class UserSystemValidators implements Serializable<Map<String,dynamic>>{
  final TypeValidator usernameValidator;

  final TypeValidator emailValidator;

  final TypeValidator nicknameValidator;

  final TypeValidator signatureValidator;

  final TypeValidator userGroupIdValidator;

  final TypeValidator userGroupDisplayNameValidator;

  final TypeValidator userGroupDescriptionValidator;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$UserSystemValidatorsToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  UserSystemValidators({
    required this.usernameValidator,
    required this.emailValidator,
    required this.nicknameValidator,
    required this.signatureValidator,
    required this.userGroupIdValidator,
    required this.userGroupDisplayNameValidator,
    required this.userGroupDescriptionValidator
  });
  factory UserSystemValidators.fromMap(Map<String,dynamic> map) => _$UserSystemValidatorsFromJson(map);
  static UserSystemValidators fromJson(Map<String,dynamic> json) => UserSystemValidators.fromMap(json);
}