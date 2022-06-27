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

  String? isUserNameValid(String? value) {
    if (value!.isEmpty) {
      return "username can't be empty";
    } else {
      return null;
    }
  }

  String? isHealthValid(String? value) {
    final result = value!.trim();
    if (result.isEmpty) {
      return "Description can't be empty";
    } else if(result.length<10){
      return "should be above 10 characters";
    }else {
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
      if (age > 200 || age < 2) {
        return "Please enter a valid age";
      } else {
        return null;
      }
    }
  }

  String? isWeightValid(String? value) {
    if (value!.isEmpty) {
      return "Weight can't be empty";
    } else {
      int weight = int.parse(value);
      if (weight > 500 || weight < 5) {
        return "Please enter a valid weight";
      } else {
        return null;
      }
    }
  }

  String? isHeightValid(String? value) {
    if (value!.isEmpty) {
      return "Height can't be empty";
    } else {
      int height = int.parse(value);
      if (height > 500 || height < 5) {
        return "Please enter a valid height";
      } else {
        return null;
      }
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
}
