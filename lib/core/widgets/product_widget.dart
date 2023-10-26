import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softagi/core/utils/colors.dart';
import 'package:softagi/layout/products/data/models/product_model.dart';

class ProductWidget extends StatelessWidget {
  Datum product;
  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(width * .015),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * .02),
          color: AppColors.primary.withOpacity(.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(product.image ?? '', height: height * .2,),
          Text(product.name ?? '', overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: height * .02, fontWeight: FontWeight.bold),),
          Text(product.description ?? '', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: AppColors.grey),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(product.price.toString() ?? ''),
              Icon(CupertinoIcons.bag_fill, color: AppColors.grey,)
            ],
          ),
        ],
      ),
    );
  }
}
