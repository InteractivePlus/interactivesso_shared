import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:json_annotation/json_annotation.dart';

import '../setting_objects/captchasubmitinfo.dart';
import '../setting_objects/validatorsbysystem/appsystem.dart';
import '../setting_objects/validatorsbysystem/usersystem.dart';
import '../util/validator.dart';

part 'shared_setting.g.dart';

class SharedSetting<CaptchaSubmitInfo extends Serializable>{
  final UserSystemValidators userSystemValidators;
  final AppSystemValidators appSystemValidators;
  final CaptchaSubmitSerializerCarrier<CaptchaSubmitInfo> captchaInfoSerializer;
  SharedSetting({required this.userSystemValidators, required this.appSystemValidators, required this.captchaInfoSerializer});
}

@JsonSerializable()
class POWChallengeSubmission implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: 'challenge_id')
  String challengeId;

  @JsonKey(required: true, name: 'nonce')
  int nonce;
  
  @override
  Map<String,dynamic> serialize([String? locale]) => _$POWChallengeSubmissionToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  POWChallengeSubmission({required this.challengeId, required this.nonce});
  factory POWChallengeSubmission.fromMap(Map<String,dynamic> map) => _$POWChallengeSubmissionFromJson(map);
  static POWChallengeSubmission fromJson(Map<String,dynamic> json) => POWChallengeSubmission.fromMap(json);
}

final SharedSetting<POWChallengeSubmission> interactiveSSOSharedSetting = SharedSetting(
  userSystemValidators: UserSystemValidators(
    usernameValidator: StringRegexValidator(regExp: RegExp(r'^[a-zA-Z]+[a-zA-Z0-9]*$'),minBytes: 3, maxBytes: 20),
    passwordFormatValidator: StringRegexValidator(regExp: RegExp(r'^[a-zA-Z0-9\.\,]*$'),minBytes: 8, maxBytes: 40),
    emailValidator: StringRegexValidator(regExp: RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"), minBytes: 5, maxBytes: 45),
    nicknameValidator: StringRegexValidator(minChars: 3, maxBytes: 25),
    signatureValidator: StringRegexValidator(maxBytes: 100),
    userGroupIdValidator: StringRegexValidator(regExp: RegExp(r'^[a-zA-Z]+[a-zA-Z0-9]*$'),minBytes: 3, maxBytes: 20),
    userGroupDisplayNameValidator: StringRegexValidator(minChars: 3, maxBytes: 25),
    userGroupDescriptionValidator: StringRegexValidator(maxBytes: 100),
  ), 
  appSystemValidators: AppSystemValidators(
    appDisplayNameValidator: StringRegexValidator(minChars: 3, maxBytes: 25),
    appDescriptionValidator: StringRegexValidator(maxBytes: 100),
    appGroupIdValidator: StringRegexValidator(regExp: RegExp(r'^[a-zA-Z]+[a-zA-Z0-9]*$'),minBytes: 3, maxBytes: 20),
    appGroupDescriptionValidator: StringRegexValidator(maxBytes: 100),
    appGroupDisplayNameValidator: StringRegexValidator(minChars: 3, maxBytes: 25)
  ), 
  captchaInfoSerializer: CaptchaSubmitSerializerCarrier<POWChallengeSubmission>(
    serializeFunc: Serializable.convertToSerialized<Map<String,dynamic>>, 
    unserializeFunc: (toConvert) {
      if(toConvert is Map<String,dynamic>){
        return POWChallengeSubmission.fromJson(toConvert);
      }else{
        throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
      }
    }
  )
);