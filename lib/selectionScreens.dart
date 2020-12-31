import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/userScreen.dart';
import 'package:flutter_app/screens/authScreen.dart';
import 'package:provider/provider.dart';

//Выбор экрана в зависимости от авторизации пользователя (если выйдет из профиля)
//загрузит экран логина
class ScreenSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return user == null ? MainWindow() : UserScreen();
  }
}