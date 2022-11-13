import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Center(
            child: Badge(
              badgeContent: const Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              animationDuration: const Duration(milliseconds: 300),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
