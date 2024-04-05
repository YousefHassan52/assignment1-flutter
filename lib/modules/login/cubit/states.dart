import 'package:assignment_two/models/userModel.dart';

abstract class LoginStates{}


class InitialLoginState extends LoginStates{}

class LoadingLoginState extends LoginStates{}
class SuccessLoginState extends LoginStates{
  String phone;

  SuccessLoginState(this.phone);
}
class FailLoginState extends LoginStates{}
