import 'package:flutter/material.dart';
import 'package:flutter_app/UserData/userData.dart';
import 'package:flutter_app/components.dart';

class UserDataForm extends StatelessWidget {
  String _uID;
  UserData _userData;

  UserDataForm(this._uID, this._userData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://allprint.moscow/wp-content/uploads/2018/10/mini-razmer.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
              child: Container(
                  color: Colors.black12,
                  width: 320,
                  height: 250,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextNameValue("User name: ", _userData.getUserName),
                        TextNameValue("First name: ", _userData.getFirstName),
                        TextNameValue("Last name: ", _userData.getLastName),
                        TextNameValue("Day Of Birthday: ", _userData.getDayOfBirthday),
                      ]),
                  ),
              )
          ),
        )
    );
  }
}