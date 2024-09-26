import 'package:flutter/scheduler.dart';
import 'package:magic/app/modules/authentication/data/models/user_model.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences_strings.dart';

void onInit(VoidCallback callback) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}

UserModel? getUser() {
  return Preferences.getModel(
    key: PreferencesStrings.userModel,
    creator: (map) => UserModel.fromMap(map),
  );
}
