// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:challange_infosys/models/product_model.dart';
import 'package:challange_infosys/providers/product_provider.dart';
import 'package:challange_infosys/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  ProductTile(this.product);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: c3),
              borderRadius: BorderRadius.circular(20)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.images.toString(),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.category.toString().toUpperCase(),
                style: c6TextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                product.title.toString(),
                style: c3TextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                '\$ ${product.price.toString()}',
                style: c1TextStyle.copyWith(fontWeight: regular, fontSize: 14),
              )
            ],
          ))
        ],
      ),
    );
  }
}
