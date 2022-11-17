import 'package:badges/badges.dart';
import 'package:cart/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Cart List',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Center(
            child: Badge(
              animationDuration: const Duration(milliseconds: 300),
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
                size: 27,
              ),
            ),
          ),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 3,
                              ),
                              child: ListTile(
                                  leading: Image.network(
                                      snapshot.data![index].image.toString()),
                                  title: Text(
                                    snapshot.data![index].productName
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Rs ${snapshot.data![index].productPrice.toString()} per ${snapshot.data![index].unitTag.toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                    ),
                                    onPressed: () {},
                                    child: Text('Add to Cart'),
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Text('No data');
                }
              })
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  ReusableWidget({super.key, required this.title, required this.value});
  String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
        style: Theme.of(context).textTheme.subtitle2,),
      ],
    );
  }
}
