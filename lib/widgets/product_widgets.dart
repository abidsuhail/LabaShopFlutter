import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/model/order_details.dart' as OrderDetails;
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';

class AddToCartButton extends StatelessWidget {
  final bool visibility;
  final Function onPressed;

  AddToCartButton({this.visibility, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: TextButton(
          onPressed: onPressed,
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
          )),
    );
  }
}

class ProductSize extends StatelessWidget {
  const ProductSize({
    Key key,
    @required this.product,
    @required this.orderDetails,
  }) : super(key: key);

  final Product product;
  final OrderDetails.OrderDetails orderDetails;

  @override
  Widget build(BuildContext context) {
    String size;
    if (product != null) {
      size =
          '${product.price.isNotEmpty ? product.price[0].size : 'N/A'} ${product.price.isNotEmpty ? product.price[0].unit : 'N/A'}';
    }
    if (orderDetails != null) {
      size =
          '${orderDetails.price.isNotEmpty ? orderDetails.price[0].size : 'N/A'} ${orderDetails.price.isNotEmpty ? orderDetails.price[0].unit : 'N/A'}';
    }
    return (product != null)
        ? Visibility(
            visible: product.price.isNotEmpty
                ? (product.price.length == 1 && product.price[0].size != '')
                : false,
            child: Text(
              size,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey),
            ),
          )
        : Text(
            size,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.grey),
          );
  }
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    @required this.product,
    @required this.productTitle,
  });

  final Product product;
  final String productTitle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        alignment: Alignment.centerLeft,
        constraints: new BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 84),
        child: Text(
          UIHelper.getHtmlUnscapeString(
              product == null ? productTitle : product.productName),
          softWrap: false,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ProductMultiplePriceDropDown extends StatefulWidget {
  Product product;
  Price dropDownValue;
  Function onSizeSelectCallback;

  ProductMultiplePriceDropDown(
      {@required this.product,
      @required this.dropDownValue,
      @required this.onSizeSelectCallback});

  @override
  _ProductMultiplePriceDropDownState createState() =>
      _ProductMultiplePriceDropDownState();
}

class _ProductMultiplePriceDropDownState
    extends State<ProductMultiplePriceDropDown> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.product.price.isNotEmpty
          ? widget.product.price.length > 1
          : false,
      child: DropdownButton(
          value: widget.dropDownValue ??
              (widget.product.price.isNotEmpty ? widget.product.price[0] : ''),
          onChanged: (newValue) {
            widget.onSizeSelectCallback(newValue);
            setState(() {
              widget.dropDownValue = newValue;
            });
          },
          items: widget.product.price.isNotEmpty
              ? widget.product.price
                  .map<DropdownMenuItem<Price>>((Price value) {
                  return DropdownMenuItem<Price>(
                    value: value,
                    child: Text(value.size),
                  );
                }).toList()
              : []),
    );
  }
}
