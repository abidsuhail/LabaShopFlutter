import 'package:labashop_flutter_app/viewmodels/cart_list_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:labashop_flutter_app/viewmodels/add_new_address_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/my_orders_list_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/payment_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/product_details_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/products_by_category_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/select_delivery_option_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/show_categories_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/your_account_fragment_vm.dart';

class AppProviders {
  AppProviders._(); //private constructor,disable Instantiation
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomeScreenVm>(
      create: (context) => HomeScreenVm(),
    ),
    ChangeNotifierProvider<CartListFragmentVm>(
      create: (context) => CartListFragmentVm(),
    ),
    ChangeNotifierProvider<FragmentNotifier>(
      create: (context) => FragmentNotifier(),
    ),
    ChangeNotifierProvider<ShowProductsByCatFragmentVm>(
      create: (context) => ShowProductsByCatFragmentVm(),
    ),
    ChangeNotifierProvider<ShowCategoriesFragmentVm>(
      create: (context) => ShowCategoriesFragmentVm(),
    ),
    ChangeNotifierProvider<SelectDeliveryOptionFragmentVm>(
      create: (context) => SelectDeliveryOptionFragmentVm(),
    ),
    ChangeNotifierProvider<AddNewAddressFragmentVm>(
      create: (context) => AddNewAddressFragmentVm(),
    ),
    ChangeNotifierProvider<PaymentFragmentVm>(
      create: (context) => PaymentFragmentVm(),
    ),
    ChangeNotifierProvider<MyOrdersListFragmentVm>(
      create: (context) => MyOrdersListFragmentVm(),
    ),
    ChangeNotifierProvider<ProductDetailsFragmentVm>(
      create: (context) => ProductDetailsFragmentVm(),
    ),
    ChangeNotifierProvider<YourAccountFragmentVm>(
      create: (context) => YourAccountFragmentVm(),
    )
  ];
}
