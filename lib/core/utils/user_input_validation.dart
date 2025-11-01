import 'package:get/get.dart';
import 'package:shopingo/core/constants/strings.dart';


userInputValidation(String val, int min, int max, String type) {
  if (type == "username") {
    RegExp regExp = RegExp('[0-9!"#\$%&\'()*+,\-./:;<=>?@\[\\\]^`{|}~]');
    if (regExp.hasMatch(val)) {
      return AppStrings.invalidUsername.tr;
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return AppStrings.invalidPhone.tr;
    }
  }

  if (val.isEmpty) {
    return AppStrings.emptyField.tr;
  }

  if (val.length < min) {
    return "${AppStrings.minLength.tr} $min";
  }

  if (val.length > max) {
    return "${AppStrings.maxLength.tr} $max";
  }

  return null;
}
