import '../constant/messages.dart';

validInput(String val, int min, int max) {
  if (val.isEmpty) {
    return "$inputEmpty";
  }
  if (val.length < min) {
    return "$inputLessMinChar $min";
  }
  if (val.length > max) {
    return "$inputMoreMaxChar $max";
  }
  return "";
}
