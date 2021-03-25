import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/ui/adapters/my_orders_list_adapter.dart';
import 'package:labashop_flutter_app/viewmodels/my_orders_list_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'home_content_fragment.dart';

class MyOrdersListFragment extends StatefulWidget {
  static const ID = 'MyOrdersListFragment';

  @override
  _MyOrdersListFragmentState createState() => _MyOrdersListFragmentState();
}

class _MyOrdersListFragmentState extends State<MyOrdersListFragment> {
  MyOrdersListFragmentVm vm;
  bool progress = false;
  @override
  void initState() {
    vm = Provider.of<MyOrdersListFragmentVm>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(HomeContentFragment.ID);
        return false;
      },
      child: ModalProgressHUD(
        inAsyncCall: progress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'My Orders',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            MyOrdersListAdapter(vm: vm),
          ],
        ),
      ),
    );
  }
}
