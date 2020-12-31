class UserData {
  String _userName;
  String _firstName;
  String _lastName;
  String _dayOfBirthday;

  UserData(this._userName, this._firstName, this._lastName, this._dayOfBirthday);

  String get getUserName => _userName;
  String get getFirstName => _firstName;
  String get getLastName => _lastName;
  String get getDayOfBirthday => _dayOfBirthday;

  void setUserName(String uName) {
    _userName = uName;
  }

  void setFirstName(String uFName) {
    _firstName = uFName;
  }

  void setLastName(String uLName) {
    _lastName = uLName;
  }

  void setDayOfBirthday(String uDayOfB) {
    _dayOfBirthday = uDayOfB;
  }
}