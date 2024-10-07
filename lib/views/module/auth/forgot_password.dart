import 'forgot/forgot_password_by_phone.dart';
import 'forgot/forgot_password_by_email.dart';

class ForgotPassword {
  static byPhone() {
    return const ForgotPasswordByPhone();
  }

  static byEmail() {
    return const ForgotPasswordByEmail();
  }
}
