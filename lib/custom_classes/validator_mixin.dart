mixin InputValidatorMixin {
  String? isNameValid(String? value) {
    if (value!.isEmpty) {
      return "Name can't be empty";
    }
    if (value.isNotEmpty && value.length < 3) {
      return "Please enter a valid name";
    } else {
      return null;
    }
  }

  String? isEmailValid(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Email can't be empty";
    }
    if (!regExp.hasMatch(value)) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }

  String? isMobileValid(String? value) {
    String pattern = r'^[6789]\d{9}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Mobile can't be empty";
    }
    if (value.length < 10 || value.length > 10 || !regExp.hasMatch(value)) {
      return "Please enter a valid mobile number";
    } else {
      return null;
    }
  }

  String? isPasswordValid(String? value) {
    if (value!.length < 8) {
      return "Password must contain 8 characters";
    } else {
      return null;
    }
  }

  String? isAgeValid(String? value) {
    if (value!.isEmpty) {
      return "Age can't be empty";
    } else {
      int age = int.parse(value);
      if (age > 99 || age < 5) {
        return "Please enter a valid age between 5 - 99";
      } else {
        return null;
      }
    }
  }

  String? isWeightValid(String? value) {
    if (value!.isNotEmpty) {
      int weight = int.parse(value);
      if (weight > 200 || weight < 5) {
        return "Please enter a valid weight between 5 - 200";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? isHeightValid(String? value) {
    if (value!.isNotEmpty) {
      int weight = int.parse(value);
      if (weight > 300 || weight < 50) {
        return "Please enter a valid height between 50 - 300";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? isQualificationValid(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return "Please select your qualification";
    }
  }

  String? isStreamValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter at least one stream";
    } else {
      return null;
    }
  }

  String? isAboutValid(String? value) {
    if (value!.isEmpty) {
      return "Please describe yourself";
    } else if (value.length < 10) {
      return "At least 10 characters";
    } else {
      return null;
    }
  }


  ///password validation for signup with minimum 8 characters and maximum 20 characters and at least one uppercase, one lowercase, one number and one special character
 // String? isPasswordValidSignup(String? value) {
 //    if (value!.length < 8) {
 //      return "Password must contain 8 characters";
 //    } else if (value.length > 20) {
 //      return "Password must contain 20 characters";
 //    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$').hasMatch(value)) {
 //      return "Password must contain at least one uppercase, one lowercase, one number and one special character";
 //    } else {
 //      return null;
 //    }
 //  }

}