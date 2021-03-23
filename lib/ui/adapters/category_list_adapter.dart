import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/widgets/list_items/category_list_item.dart';

class CategoryListAdapter extends StatelessWidget {
  const CategoryListAdapter({
    @required this.categoryList,
    @required this.onCatClick,
  });

  final List<Category> categoryList;
  final Function onCatClick;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(categoryList == null ? 0 : categoryList.length,
          (index) {
        return GestureDetector(
          onTap: () {
            if (onCatClick != null) {
              onCatClick(categoryList[index]);
            } else {
              UIHelper.showShortToast('Please implement onCatClick');
            }
          },
          child: ProductCategoryListItem(
            categoryImage: categoryList[index].categoryImg,
            categoryName: categoryList[index].categoryName,
          ),
        );
      }),
    );
  }
}
