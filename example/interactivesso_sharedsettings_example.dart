import 'package:interactivesso_sharedsettings/interactivesso_sharedsettings.dart';

void main() {
  final SharedSetting sharedSetting = interactiveSSOSharedSetting;
  print('userSystem:' + sharedSetting.userSystemValidators.toJson().toString());
  print('appSystem:' + sharedSetting.userSystemValidators.toJson().toString());
}
