class UserReg {
  String? _username;
  String? _email;
  String? _password;

  UserReg({String? username, String? email, String? password}) {
    if (username != null) {
      this._username = username;
    }
    if (email != null) {
      this._email = email;
    }
    if (password != null) {
      this._password = password;
    }
  }

  String? get username => _username;
  set username(String? username) => _username = username;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;

  UserReg.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _email = json['email'];
    _password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._username;
    data['email'] = this._email;
    data['password'] = this._password;
    return data;
  }
}
