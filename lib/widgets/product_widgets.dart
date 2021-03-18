import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
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
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: product.price.isNotEmpty
          ? (product.price.length == 1 && product.price[0].size != '')
          : false,
      child: Text(
        '${product.price.isNotEmpty ? product.price[0].size : 'N/A'} ${product.price.isNotEmpty ? product.price[0].unit : 'N/A'}',
        textAlign: TextAlign.start,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        alignment: Alignment.centerLeft,
        constraints: new BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 84),
        child: Text(
          UIHelper.getHtmlUnscapeString(product.productName),
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

  ProductMultiplePriceDropDown(
      {@required this.product, @required this.dropDownValue});

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
