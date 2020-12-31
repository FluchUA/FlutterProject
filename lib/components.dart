import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/FireBase/auth.dart';

//Кнопка
class ButtonComponent extends StatelessWidget {
  String _textButton;
  Function _func;
  ButtonComponent(this._textButton, this._func);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        child: Padding (
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: RaisedButton(
              color: Colors.black12,
              onPressed: () {
                _func();
              },
              child: Text(
                _textButton,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
        )
    );
  }
}

//Текст по средине
class TextCenterComponent extends StatelessWidget {
  String _str;
  TextCenterComponent(this._str);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Text(
        _str,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

//Поле ввода
class InputComponent extends StatelessWidget {
  Icon _icon;
  String _hintStr;
  bool _showPassword;
  int _minLines;
  int _maxLines;
  TextEditingController _textECntrl;

  InputComponent(this._icon, this._hintStr, this._textECntrl, this._showPassword, this._minLines, this._maxLines);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: _textECntrl,
          obscureText: _showPassword,
          minLines: _minLines,
          maxLines: _maxLines,
          decoration: InputDecoration(
              hintText: _hintStr,
              prefixIcon: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: _icon,
              )
          ),
        )
    );
  }
}

//Часть статическо текста и кликабельного
class TextWithButton extends StatelessWidget {
  String _text;
  String _textClick;
  Function _func;

  TextWithButton(this._text, this._textClick, this._func);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: <TextSpan> [
              TextSpan(
                  text: _text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  )
              ),
              TextSpan(
                text: _textClick,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
                recognizer: TapGestureRecognizer()..onTap = () => _func(),
              ),
            ]
        )
    );
  }
}

//Кнопка - иконка выхода их профиля
class IconButtonLogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.logout,
        size: 30,
      ),
      onPressed: () => FireAuth().logOut(),
    );
  }
}

//Выводит текст в формате: текст - значение
class TextNameValue extends StatelessWidget {
  String _name;
  String _value;

  TextNameValue(this._name, this._value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: _name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    )
                ),
                TextSpan(
                  text: _value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ]
          )
      ),
    );
  }
}