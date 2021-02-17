import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore _loginStore = LoginStore();
  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // _loginStore = Provider.of<LoginStore>(context);

    disposer = reaction(
            (_) => _loginStore.isLoggedIn,
            (loggedIn){
          if(loggedIn)
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_)=>ListScreen())
            );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 24,
                    ),
                    Observer(
                      builder: (context) {
                        return CustomTextField(
                          hint: 'E-mail',
                          prefix: Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: _loginStore.setEmail,
                          enabled: !_loginStore.isLoading,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Observer(
                      builder: (context) {
                        return CustomTextField(
                          hint: 'Senha',
                          prefix: Icon(Icons.lock),
                          obscure: !_loginStore.isPasswordVisibility,
                          onChanged: _loginStore.setPassword,
                          enabled: !_loginStore.isLoading,
                          suffix: CustomIconButton(
                              radius: 32,
                              iconData: _loginStore.isPasswordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: _loginStore.togglePasswordVisibility),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Observer(
                      builder: (context) {
                        return SizedBox(
                          height: 44,
                          width: 210,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: _loginStore.isLoading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : Text('Login'),
                              color: Theme.of(context).primaryColor,
                              disabledColor:
                                  Theme.of(context).primaryColor.withAlpha(100),
                              textColor: Colors.white,
                              onPressed: _loginStore.loginPressed),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
