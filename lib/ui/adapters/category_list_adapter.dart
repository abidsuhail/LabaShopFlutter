import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_category_list_item.dart';

class CategoryListAdapter extends StatelessWidget {
  const CategoryListAdapter({
    @required this.categoryList,
  });

  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(categoryList == null ? 0 : categoryList.length,
          (index) {
        return ProductCategoryListItem(
          categoryImage: categoryList[index].categoryImg,
          categoryName: categoryList[index].categoryName,
        );
      }),
    );
  }
}
