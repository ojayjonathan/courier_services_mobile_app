String? requiredValidator(String? value) {
  if (value == null) {
    return "Required";
  }
  if (value.isEmpty) {
    return "Required";
  }
}

String? phoneValidator(String? value) {
  RegExp re = new RegExp(r"0(1|7)\d{8}");
  if (value == null) {
    return "Required";
  }
  if (!re.hasMatch(value)) {
    return "Please provide valid phone number eg 0712234576 or 0112234576";
  }
}

String? passwordValidator(String? value) {
  if (value == null) {
    return "Required";
  }
  if (value.isEmpty) {
    return "Required";
  } else if (value.length < 6) {
    return "Should be atleast 6 characters";
  } else if (value.length > 15) {
    return "Should be atmost 15 characters";
  } else {
    return null;
  }
}

String? emailValidator(String? string) {
  // Null or empty string is invalid
  if (string == null || string.isEmpty) {
    return "Required";
  }
  string = string.trim();

  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return "Enter a valid email address";
  }
  return null;
}
