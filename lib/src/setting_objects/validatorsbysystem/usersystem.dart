import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../util/validator.dart';

part 'usersystem.g.dart';

@JsonSerializable()
@TypeValidatorStringJsonConverter()
class UserSystemValidators implements Serializable<Map<String,dynamic>>{
  final TypeValidator<String> usernameValidator;

  final TypeValidator<String> passwordFormatValidator;

  final TypeValidator<String> emailValidator;

  final TypeValidator<String> nicknameValidator;

  final TypeValidator<String> signatureValidator;

  final TypeValidator<String> userGroupIdValidator;

  final TypeValidator<String> userGroupDisplayNameValidator;

  final TypeValidator<String> userGroupDescriptionValidator;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$UserSystemValidatorsToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  UserSystemValidators({
    required this.usernameValidator,
    required this.passwordFormatValidator,
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