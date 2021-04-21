import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:labashop_flutter_app/model/category.dart' as LabaCat;
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/ui/fragments/about_us_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/add_new_address_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/cart_list_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/contact_us_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/my_orders_list_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/order_details_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/payment_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/payment_online_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/product_details_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/select_delivery_option_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/show_categories_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/show_products_by_cat_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/wishlist_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/your_account_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:stack/stack.dart' as MyStack;

class FragmentNotifier extends ChangeNotifier {
  Widget selectedFragment;
  static MyStack.Stack<Widget> fragmentStack = MyStack.Stack();
  List<Widget> _fragments = [HomeContentFragment()];

  FragmentNotifier() {
    selectedFragment = HomeContentFragment();
    fragmentStack.push(selectedFragment);
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
      case ProductDetailsFragment.ID:
        if (object != null && object is Product) {
          selectedFragment = ProductDetailsFragment(product: object);
        } else {
          UIHelper.showShortToast('Invalid order details!!');
        }
        break;
      case YourAccountFragment.ID:
        selectedFragment = YourAccountFragment();
        break;
      case WishListFragment.ID:
        selectedFragment = WishListFragment();
        break;
      case ContactUsFragment.ID:
        selectedFragment = ContactUsFragment();
        break;
      case AboutUsFragment.ID:
        selectedFragment = AboutUsFragment();
        break;
      case PaymentOnlineFragment.ID:
        selectedFragment = PaymentOnlineFragment();
        break;
    }
    fragmentStack.push(selectedFragment);
    notifyListeners();
  }

  void navigatedBack() {
    fragmentStack.pop();
    selectedFragment = fragmentStack.top();
    notifyListeners();
  }
}
