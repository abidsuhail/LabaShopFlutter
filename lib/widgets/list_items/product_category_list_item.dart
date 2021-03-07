import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';

class ProductCategoryListItem extends StatelessWidget {
  final String categoryImage,categoryName;
  ProductCategoryListItem({this.categoryName,this.categoryImage});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                categoryImage,
                fit: BoxFit.fill,
                height: 100,
                width: 120,
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  UIHelper.getHtmlUnscapeString(categoryName),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
              ),
            ]),
      ),
    );
  }
}
