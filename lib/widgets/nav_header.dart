import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:provider/provider.dart';

class NavHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserNotifier>(context).initUser();
    return UserAccountsDrawerHeader(
      accountName: Text(Provider.of<UserNotifier>(context).user.name ?? ""),
      accountEmail: Text(Provider.of<UserNotifier>(context).user.email ?? ""),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blue
            : Colors.white,
        child: Text(
          "A",
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}

//TODO make viewmodel as changenotifier
class UserNotifier extends ChangeNotifier {
  User user = User(name: '', email: '');
  void initUser() async {
    user = await AppSharedPrefs.getUserFromDb();
    notifyListeners();
  }
}
