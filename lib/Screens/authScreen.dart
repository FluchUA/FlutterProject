import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/FireBase/auth.dart';
import 'package:flutter_app/components.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "My Notes",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  createState() => new _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  //Контроллеры полей ввода, хранят введенную информацию
  TextEditingController _emailCntrl = TextEditingController();
  TextEditingController _passwordCntrl = TextEditingController();

  FireAuth _fireAuth = FireAuth();
  bool _haveAccount = true;

  //Авторизация пользователя
  void LoginUser() async {
    if (_emailCntrl.text.isEmpty || _passwordCntrl.text.isEmpty) return;
    User user =
        await _fireAuth.loginUser(_emailCntrl.text, _passwordCntrl.text);

    if (user == null) {
      Fluttertoast.showToast(
          msg: "Incorrect username or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailCntrl.clear();
      _passwordCntrl.clear();
    }
  }

  //Регистрация пользователя
  void RegisterUser() async {
    if (_emailCntrl.text.isEmpty || _passwordCntrl.text.isEmpty) return;
    User user =
        await _fireAuth.registerUser(_emailCntrl.text, _passwordCntrl.text);

    if (user == null) {
      Fluttertoast.showToast(
          msg: "Incorrect username or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailCntrl.clear();
      _passwordCntrl.clear();
    }
  }

  //Сменить регистрацию на вход и наоборот с последующей перестройкой виджетов
  void SingUpIn() {
    setState(() {
      _haveAccount = !_haveAccount;
      _emailCntrl.clear();
      _passwordCntrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://image.freepik.com/free-photo/top-view-for-business-background-blank-notebook-for-painting-drawing-and-sketching-on-wooden-texture_64749-2747.jpg"),
              fit: BoxFit.cover)),
      child: Center(
          child: Container(
              color: Color.fromARGB(50, 40, 40, 40),
              width: 300,
              height: 260,
              child: Column(
                children: [
                  _haveAccount
                      ? TextCenterComponent("Log In to Your Account")
                      : TextCenterComponent("Register Your Account"),

                  InputComponent(
                      Icon(Icons.email), "Email", _emailCntrl, false, 1, 1),
                  InputComponent(
                      Icon(Icons.lock), "Password", _passwordCntrl, true, 1, 1),

                  //Если пользователь имеет аккаунт вывод формы входа, иначе форма регистрации
                  _haveAccount
                      ? Column(
                          children: [
                            ButtonComponent("Login", LoginUser),
                            TextWithButton(
                                "Don't have an account? ", "Sign Up", SingUpIn),
                          ],
                        )
                      : Column(
                          children: [
                            ButtonComponent("Register", RegisterUser),
                            TextWithButton("Already have an account? ",
                                "Sign In", SingUpIn),
                          ],
                        )
                ],
              ))),
    );
  }
}
