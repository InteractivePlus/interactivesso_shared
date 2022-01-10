
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';

class CaptchaSubmitSerializerCarrier<CaptchaSubmitInfo extends Serializable>{
  final dynamic Function(CaptchaSubmitInfo info) serializeFunc;
  final CaptchaSubmitInfo Function(dynamic serialized) unserializeFunc;
  CaptchaSubmitSerializerCarrier({required this.serializeFunc, required this.unserializeFunc});
}