class User {
  int _userId;
  String _username;
  int _userRole;
  String _name;
  String _email;
  String _phone;
  String _authtoken;

  User(
      {int userId,
        String username,
        int userRole,
        String name,
        String email,
        String phone,
        String authtoken}) {
    this._userId = userId;
    this._username = username;
    this._userRole = userRole;
    this._name = name;
    this._email = email;
    this._phone = phone;
    this._authtoken = authtoken;
  }

  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get username => _username;
  set username(String username) => _username = username;
  int get userRole => _userRole;
  set userRole(int userRole) => _userRole = userRole;
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get authtoken => _authtoken;
  set authtoken(String authtoken) => _authtoken = authtoken;

  User.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _username = json['username'];
    _userRole = json['user_role'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _authtoken = json['authtoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['username'] = this._username;
    data['user_role'] = this._userRole;
    data['name'] = this._name;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['authtoken'] = this._authtoken;
    return data;
  }
}