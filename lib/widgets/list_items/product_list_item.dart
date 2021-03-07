import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    @required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: CachedNetworkImage(
              height: 120,
              width: 120,
              imageUrl: "${product.productImg[0]}",
      /*        placeholder: (context, url) => Padding(
                  padding: EdgeInsets.all(60),
                  child: CircularProgressIndicator()),*/
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    constraints: new BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 84),

                    child: Flexible(
                      child: Text(UIHelper.getHtmlUnscapeString(product.productName),
                          softWrap: false,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,),
                    ),
                  ),
                ),
                Text('${product.price.isNotEmpty?product.price[0].size:'N/A'} ${product.price.isNotEmpty?product.price[0].unit:'N/A'}',textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.grey
                ),),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rs.${product.price.isNotEmpty?product.price[0].cost:'N/A'}',style: TextStyle(
                        //TODO change N/A to number later
                          fontWeight: FontWeight.bold
                      )),
                      TextButton(
                          onPressed: () {
                            //TODO add to cart
                          },
                          child: Container(
                            color: Color(AppColors.colorPrimary),
                            padding: EdgeInsets.all(6),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                  backgroundColor: Color(AppColors.colorPrimary),
                                  color: Colors.white,

                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Container(
                    color: Colors.black,
                    height: 1,
                    child: SizedBox(width: double.infinity))
              ],
            ),
          )
        ],
      ),
    );
  }
}
