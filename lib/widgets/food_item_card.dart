import 'package:flutter/material.dart';

class FoodItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final VoidCallback onAddToCart;

  FoodItemCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.orange, fontSize: 14),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onAddToCart,
                  child: Text('Add to Cart'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
