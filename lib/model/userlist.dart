import 'package:labashop_flutter_app/model/user.dart';

class UserList
{
  final List<UserData> users;
  UserList({this.users});
  factory UserList.fromJson(List<dynamic> parsedJson) {

    List<UserData> users = parsedJson.map((i)=>UserData.fromJson(i)).toList();
    return new UserList(
      users: users,
    );
  }
}