class Validator {
  static String? validateEmail(String? value) {
    if (value!.trim().isNotEmpty) {
      return 'Field cannot be not empty';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'invalid Email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.trim().isNotEmpty) {
      return 'Please provide a password';
    }
    if (value.length < 6) {
      return 'your password is too short';
    }
    return null;
  }

  static String? validateSimpleString(String? value) {
    if (value!.trim().isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? validateEmail1(String? value) {
    if (value == null || value.length < 4) {
      return 'Please enter Your Email';
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  static String? validatePassword1(String? value) {
    if (value == null || value.length < 4) {
      return 'Password is to short';
    }

    const pattern = r"^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+$";
    final regex = RegExp(pattern);

    return value.isNotEmpty && regex.hasMatch(value)
        ? null
        : 'Enter a Password with letters and number Only';
  }

  static String? validateName(String? value) {
    if (value==null || value.length < 3) {
      return 'UserName is to short';
    }
    const pattern =r"^[a-zA-Z]+(\s[a-zA-Z]+)?$";
    // r"^[A-Za-z][A-Za-z0-9_]{7,29}$";
    final regex = RegExp(pattern);

    return value.isNotEmpty && regex.hasMatch(value)
        ? null
        : "Enter Full Name Don't use number !";
  }
}