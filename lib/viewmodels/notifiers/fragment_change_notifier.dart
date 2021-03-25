import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:labashop_flutter_app/model/category.dart' as LabaCat;
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/ui/fragments/add_new_address_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/cart_list_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/my_orders_list_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/order_details_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/payment_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/select_delivery_option_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/show_categories_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/show_products_by_cat_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';

class FragmentNotifier extends ChangeNotifier {
  Widget selectedFragment;
  FragmentNotifier() {
    selectedFragment = HomeContentFragment();
  }
  void setFargment(String fragmentId, {Object object}) {
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
      case ShowProductsByCatFragment.ID:
        if (object != null && object is LabaCat.Category) {
          selectedFragment = ShowProductsByCatFragment(category: object);
        } else {
          UIHelper.showShortToast('Invalid category!!');
        }
        break;
      case SelectDeliveryOptionFragment.ID:
        selectedFragment = SelectDeliveryOptionFragment();
        break;
      case AddNewAddressFragment.ID:
        selectedFragment = AddNewAddressFragment();
        break;
      case PaymentFragment.ID:
        selectedFragment = PaymentFragment();
        break;
      case OrderDetailsFragment.ID:
        if (object != null && object is List<OrderDetails>) {
          selectedFragment = OrderDetailsFragment(object);
        } else {
          UIHelper.showShortToast('Invalid order details!!');
        }
        break;
      case MyOrdersListFragment.ID:
        selectedFragment = MyOrdersListFragment();
        break;
    }
    notifyListeners();
  }
}
