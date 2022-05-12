import 'package:infinito_wallet/components/rounded_email_field.dart';
import 'package:infinito_wallet/components/rounded_password_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('empty email returns error string', () {

    final result = EmailFieldValidator.validate('');
    expect(result, 'Hãy nhập Email của bạn');
  });

  test('email with wrong format', () {

    final result = EmailFieldValidator.validate('email');
    expect(result, 'Email không hợp lệ');
  });

  test('non-empty email returns null', () {
    final result = EmailFieldValidator.validate('email@gmail.com');
    expect(result, null);
  });

  test('empty password returns error string', () {

    final result = PasswordFieldValidator.validate('');
    expect(result, 'Yêu cầu nhập mật khẩu');
  });

  test('non-empty password with wrong format', () {

    final result = PasswordFieldValidator.validate('123');
    expect(result, 'Nhập đúng định dạng mật khẩu (Tối thiểu 8 kí tự)');
  });

  test('non-empty password returns null', () {

    final result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });
}