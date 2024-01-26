import 'package:flutter/material.dart';
import 'main.dart'; // Import main.dart to access GroceryItem and Cart classes

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GroceryItem> cartItems = Cart.instance.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text('Your cart is empty.'),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(cartItems[index].imageAssetPath),
            title: Text(cartItems[index].name),
            subtitle: Text('Price: \$${cartItems[index].price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                // Remove the item from the cart
                Cart.instance.remove(cartItems[index]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${cartItems[index].name} removed from cart.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
