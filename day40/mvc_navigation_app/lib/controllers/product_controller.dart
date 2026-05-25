import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../views/product_detail_view.dart';

class ProductController {
  final List<ProductModel> products = [
    ProductModel(
      name: "Laptop",
      description: "High performance laptop for coding and gaming.",
      price: 75000,
    ),
    ProductModel(
      name: "Smartphone",
      description: "Latest Android smartphone with great camera.",
      price: 35000,
    ),
    ProductModel(
      name: "Headphones",
      description: "Wireless noise cancelling headphones.",
      price: 5000,
    ),
    ProductModel(
      name: "Smart Watch",
      description: "Fitness tracking smart watch.",
      price: 7000,
    ),
  ];

  void navigateToDetail(
    BuildContext context,
    ProductModel product,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailView(product: product),
      ),
    );
  }
}