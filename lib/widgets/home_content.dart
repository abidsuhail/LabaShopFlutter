import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/widgets/search_text_field.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              height: 240,
              color: Color(AppColors.colorPrimary),
              child: Column(
                children: [
                  SearchTextField(),
                  SizedBox(
                    height: 8,
                  ),
                  Image.network(
                      'http://thelabashopping.com////admin//images//banners//3//b21.jpg'),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Text(
              'Shop By Category',
              style: TextStyle(fontSize: 20, color: Colors.grey,),
              textAlign: TextAlign.start,
            )
          ],
        ),
      ),
    );
  }
}
