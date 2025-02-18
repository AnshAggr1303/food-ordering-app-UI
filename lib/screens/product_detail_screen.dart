import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final double price;
  final String description;
  final String image;
  final List<String> sizes;
  final List<String> variants;
  final List<String> drinks;
  final List<Map<String, dynamic>> cart; // Cart List

  ProductDetailScreen({
    required this.productName,
    required this.price,
    required this.description,
    required this.image,
    required this.sizes,
    required this.variants,
    required this.drinks,
    required this.cart,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  String selectedSize = "";
  String selectedVariant = "";
  String selectedDrink = "";

  @override
  void initState() {
    super.initState();
    selectedSize = widget.sizes.isNotEmpty ? widget.sizes.first : "";
    selectedVariant = widget.variants.isNotEmpty ? widget.variants.first : "";
    selectedDrink = widget.drinks.isNotEmpty ? widget.drinks.first : "";
  }

  void updateQuantity(int change) {
    setState(() {
      quantity = (quantity + change).clamp(1, 10);
    });
  }

  void addToCart() {
    widget.cart.add({
      'name': widget.productName,
      'price': widget.price * quantity,
      'size': selectedSize,
      'variant': selectedVariant,
      'drink': selectedDrink,
      'quantity': quantity,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.productName} added to cart"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context); // Go back after adding to cart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              SizedBox(height: 40),
              // Back Button + Title + Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    widget.productName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${widget.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Product Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    widget.image,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Size Selection
              Text('Size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.sizes.map((size) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(size),
                      selected: selectedSize == size,
                      onSelected: (_) => setState(() => selectedSize = size),
                      selectedColor: Colors.orange.shade200,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(color: selectedSize == size ? Colors.black : Colors.grey),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Quantity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${widget.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.black),
                        onPressed: () => updateQuantity(-1),
                      ),
                      Text('$quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.black),
                        onPressed: () => updateQuantity(1),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Description
              Text(widget.description, style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 20),

              // Variant Selection
              Text('Select Variant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: widget.variants.map((variant) {
                  return ChoiceChip(
                    label: Text(variant),
                    selected: selectedVariant == variant,
                    onSelected: (_) => setState(() => selectedVariant = variant),
                    selectedColor: Colors.orange.shade200,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(color: selectedVariant == variant ? Colors.black : Colors.grey),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Drink Selection
              Text('Select a Drink', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: widget.drinks.map((drink) {
                  return ChoiceChip(
                    label: Text(drink),
                    selected: selectedDrink == drink,
                    onSelected: (_) => setState(() => selectedDrink = drink),
                    selectedColor: Colors.orange.shade200,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(color: selectedDrink == drink ? Colors.black : Colors.grey),
                  );
                }).toList(),
              ),
              SizedBox(height: 80), // Added bottom space for button
            ],
          ),

          // Add to Cart Button (Fixed at Bottom)
          Positioned(
            bottom: 10,
            left: 16,
            right: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: addToCart,
              child: Text('Add to Bag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
