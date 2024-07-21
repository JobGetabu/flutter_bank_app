import 'package:dependencies/dependencies.dart';
import 'package:features/utils/size_config.dart';
import 'package:flutter/widgets.dart';

void setUpScreenUtil(BuildContext context) {
  ScreenUtil.init(context);
  SizeConfig().init(context);
}

bool isKeyboardShowing() {
  try {
    if (WidgetsBinding.instance != null) {
      return WidgetsBinding.instance.window.viewInsets.bottom > 0;
    } else {
      return false;
    }
  } catch (e) {
    Fimber.w('Keyboard not closing!');
  }
  return false;
}

closeKeyboard(BuildContext context) {
  try {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  } catch (e) {
    Fimber.w('Keyboard not closing!');
  }
}

