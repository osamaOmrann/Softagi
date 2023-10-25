class ValidationUtils {
  static bool isValidEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isValidPhoneNumber(String number) {
    return RegExp(r"^01[0125][0-9]{8}$").hasMatch(number);
  }
}