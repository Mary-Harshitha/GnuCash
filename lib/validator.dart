class FieldValidator {
  static String ValidateEmail(String value) {
    if(value.isEmpty) 
      return 'Enter your email address';
    else 
      return null;
  }

  static String ValidatePassword(String value) {
    if(value.isEmpty) 
      return 'Enter a password';
    else if(value.length < 6)
      return "Password of atleast 6 characters";
    else 
      return null;
  }
}