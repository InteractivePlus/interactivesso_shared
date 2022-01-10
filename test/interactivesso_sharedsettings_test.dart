import 'dart:math';

import 'package:interactivesso_sharedsettings/interactivesso_sharedsettings.dart';
import 'package:test/test.dart';

void main() {
  group('UserSystemValidatorTest', () {
    final SharedSetting sharedSetting = interactiveSSOSharedSetting;

    setUp(() {
      // Additional setup goes here.
    });

    test('Username', () {
      expect(interactiveSSOSharedSetting.userSystemValidators.usernameValidator.validateDynamic('user1'), true);
      expect(interactiveSSOSharedSetting.userSystemValidators.usernameValidator.validateDynamic(123),false);
      expect(interactiveSSOSharedSetting.userSystemValidators.usernameValidator.validateDynamic('好家伙!'),false);
    });
    test('Email',(){
      expect(interactiveSSOSharedSetting.userSystemValidators.emailValidator.validateDynamic('123'), false);
      expect(interactiveSSOSharedSetting.userSystemValidators.emailValidator.validate('123@example.com'),true);
    });
  });
}
