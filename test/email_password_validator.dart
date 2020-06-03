import 'package:gnu_cash/validator.dart';
import 'package:test/test.dart';

void main() {
  group('Unit test, ', (){
    test('empty email test', (){
      var result = FieldValidator.ValidateEmail('');
      expect(result, 'Enter your email address');
    });
    test('email test', (){
      var result = FieldValidator.ValidateEmail('aa@gg.com');
      expect(result, null);
    });
    test('empty password test', (){
      var result = FieldValidator.ValidatePassword('');
      expect(result, 'Enter a password');
    });
    test('password minimum character test', (){
      var result = FieldValidator.ValidatePassword('gggg');
      expect(result, 'Password of atleast 6 characters');
    });
    test('password test', (){
      var result = FieldValidator.ValidatePassword('gggggggg');
      expect(result, null);
    });
  });
}