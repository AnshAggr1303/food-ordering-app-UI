import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartScreen({this.cartItems = const []});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Map<String, dynamic>> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
  }

  void removeItem(int index) {
    if (!mounted) return; // ✅ Prevents update on unmounted widget
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0, (sum, item) => sum + (item['price'] ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.orange, // ✅ Orange theme applied
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.fastfood, color: Colors.orange),
                  title: Text(cartItems[index]['name'] ?? 'Unknown Item'),
                  subtitle: Text('\$${cartItems[index]['price']?.toStringAsFixed(2) ?? '0.00'}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => removeItem(index),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16), // ✅ Added spacing before the checkout button
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // ✅ Updated to orange theme
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: cartItems.isNotEmpty
                  ? () {
                if (!mounted) return; // ✅ Ensures the widget is still mounted before navigation
                Future.delayed(Duration.zero, () { // ✅ Ensures safe context usage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(totalAmount: totalAmount),
                    ),
                  );
                });
              }
                  : null,
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 70), // ✅ Extra space to avoid bottom overlap
        ],
      ),
    );
  }
}
