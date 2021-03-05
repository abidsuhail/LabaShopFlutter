import 'package:labashop_flutter_app/model/user.dart';

class UserList
{
  final List<User> users;
  UserList({this.users});
  factory UserList.fromJson(List<dynamic> parsedJson) {

    List<User> users = parsedJson.map((i)=>User.fromJson(i)).toList();
    return new UserList(
      users: users,
    );
  }
}