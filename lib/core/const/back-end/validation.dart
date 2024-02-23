class Validation {
  static bool isVietnamesePhoneNumber(String phoneNumber) {
    //begin with 0 and have 10 digits
    return isContainSpecialCharacter(phoneNumber)
        ? false
        : RegExp(r'^0\d{9}$').hasMatch(phoneNumber);
  }

  static bool isContainSpecialCharacter(String text) {
    return RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(text);
  }

  static String? capitalizeFirstLetter(String text) {
    return isContainSpecialCharacter(text)
        ? null
        : text.split(' ').map((word) {
            if (word.isEmpty) return null;
            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          }).join(' ');
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static bool isValidPassword(String password) {
    //Minimum eight characters, at least one uppercase letter, one lowwercase letter, one special letter and one number, no space
    return RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$!%?])[A-Za-z\d@#$!%?]{8,}$')
        .hasMatch(password);
  }
}
