import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:json_annotation/json_annotation.dart';

import 'validatorsbysystem/appsystem.dart';
import 'validatorsbysystem/usersystem.dart';

part 'validators.g.dart';

@JsonSerializable()
class Validators implements Serializable<Map<String,dynamic>>{
  final AppSystemValidators appSystemValidators;
  final UserSystemValidators userSystemValidators;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$ValidatorsToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  Validators({required this.appSystemValidators, required this.userSystemValidators});
  factory Validators.fromMap(Map<String,dynamic> map) => _$ValidatorsFromJson(map);
  static Validators fromJson(Map<String,dynamic> json) => Validators.fromMap(json);
}