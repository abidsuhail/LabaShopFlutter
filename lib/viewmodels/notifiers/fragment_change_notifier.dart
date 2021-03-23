import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:labashop_flutter_app/ui/fragments/cart_list_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/show_categories_fragment.dart';

class FragmentNotifier extends ChangeNotifier {
  Widget selectedFragment;
  FragmentNotifier() {
    selectedFragment = HomeContentFragment();
  }
  void setFargment(String fragmentId) {
    switch (fragmentId) {
      case HomeContentFragment.ID:
        selectedFragment = HomeContentFragment();
        break;
      case CartListFragment.ID:
        selectedFragment = CartListFragment();
        break;
      case ShowCategoriesFragment.ID:
        selectedFragment = ShowCategoriesFragment();
        break;
    }
    notifyListeners();
  }
}
