import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String _email = "";

  @observable
  String _password = "";

  @observable
  bool _loading = false;

  @observable
  bool _passwordVisibility = false;

  @observable
  bool _loggedIn = false;

  @action
  void setEmail(String value) {
    _email = value;
  }

  @action
  void setPassword(String value) {
    _password = value;
  }

  @computed
  bool get isEmailValid {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(_email);
  }

  @computed
  bool get isLoggedIn {
    return _loggedIn;
  }

  @computed
  bool get isPasswordValid {
    return _password.length >= 6;
  }

  @computed
  bool get isPasswordVisibility {
    return _passwordVisibility;
  }

  @computed
  bool get isLoading {
    return _loading;
  }

  @action
  Future<void> login() async {
    _loading = true;
    await Future.delayed(Duration(seconds: 5));

    _loading = false;
    _loggedIn = true;

    _email = '';
    _password = '';
  }

  @action
  void togglePasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
  }

  @computed
  Function get loginPressed {
    return (isEmailValid && isPasswordValid && !isLoading) ? login : null;
  }

  @action
  void logout() {
    _loggedIn = false;
  }
}

import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

}
