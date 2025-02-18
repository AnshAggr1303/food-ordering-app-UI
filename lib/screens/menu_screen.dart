import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

class MenuScreen extends StatefulWidget {
  final String restaurantName;
  final List<Map<String, dynamic>> cart;

  MenuScreen({required this.restaurantName, required this.cart});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Whopper',
      'price': 5.99,
      'description': 'Classic delight with onion and mustard sauce.',
      'image': 'assets/images/burger.jpeg',
      'veg': true,
      'sizes': ['Small', 'Medium', 'Large'],
      'variants': ['BBQ', 'Classic'],
      'drinks': ['Coke', 'Water']
    },
    {
      'name': 'BBQ Chicken Burger',
      'price': 6.99,
      'description': 'Smoky BBQ sauce with grilled chicken patty and cheese.',
      'image': 'assets/images/chicken_burger.jpeg',
      'veg': false,
      'sizes': ['Small', 'Medium', 'Large'],
      'variants': ['BBQ', 'Spicy'],
      'drinks': ['Sprite', 'Lemonade']
    },
    {
      'name': 'Pasta Alfredo',
      'price': 7.99,
      'description': 'Creamy white sauce pasta with parmesan and herbs.',
      'image': 'assets/images/pasta.jpeg',
      'veg': true,
      'sizes': ['Regular', 'Large'],
      'variants': ['Cheesy', 'Classic'],
      'drinks': ['Wine', 'Water']
    },
    {
      'name': 'Pepperoni Pizza',
      'price': 8.99,
      'description': 'Topped with spicy pepperoni and mozzarella cheese.',
      'image': 'assets/images/pizza.jpeg',
      'veg': false,
      'sizes': ['Small', 'Medium', 'Large'],
      'variants': ['Cheesy', 'Classic'],
      'drinks': ['Pepsi', 'Lemonade']
    },
  ];

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      widget.cart.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            // Back Button (Fully Left-Aligned)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 24),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(height: 10),
            // Centered Restaurant Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.restaurantName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Burger, Pasta, Coffee',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Centered Rating Badge
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.green, size: 16),
                    SizedBox(width: 5),
                    Text(
                      '4.0',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Menu Section Title (Still Left-Aligned for Better Readability)
            Text('Menu', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...menuItems.map((item) => _buildMenuItem(item)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(cartItems: widget.cart),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.shopping_cart),
            if (widget.cart.isNotEmpty)
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    widget.cart.length.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    bool isVeg = item['veg'] ?? false;

    return GestureDetector(
      onTap: () {
        // Navigate to Product Detail Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productName: item['name'],
              price: item['price'],
              description: item['description'],
              image: item['image'],
              sizes: List<String>.from(item['sizes']),
              variants: List<String>.from(item['variants']),
              drinks: List<String>.from(item['drinks']),
              cart: widget.cart, // Pass cart to allow adding items
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.circle, color: isVeg ? Colors.green : Colors.red, size: 14),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'] ?? 'Unknown Item',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(item['description'] ?? 'Delicious food item',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item['image'] ?? 'assets/images/placeholder.jpeg',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => addToCart(item),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    ),
                    child: Text('ADD', style: TextStyle(color: Colors.green, fontSize: 14)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
