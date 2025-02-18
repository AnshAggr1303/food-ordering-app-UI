import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'cart_screen.dart';
import 'order_tracking_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> cart = [];

  List<Widget> get _screens => [
    HomeScreenContent(cart: cart),
    CartScreen(cartItems: cart),
    OrderTrackingScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? _buildHomeAppBar() : null,
      body: Stack(
        children: [
          _screens[_selectedIndex], // Main content (Home, Cart, Orders, Profile)
          _buildFloatingBottomNavigationBar(), // Overlapping Bottom Bar
        ],
      ),
    );
  }

  /// **App Bar for Home Screen**
  PreferredSizeWidget _buildHomeAppBar() {
    return AppBar(
      toolbarHeight: 100, // Increased height for better spacing
      elevation: 0, // No shadow for a clean look
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deliver to:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Row(
            children: [
              Text(
                '08776 Serenity Ports, New York',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            child: Icon(Icons.person, color: Colors.black),
          ),
        ),
      ],
    );
  }

  /// **Floating Bottom Navigation Bar**
  Widget _buildFloatingBottomNavigationBar() {
    return Positioned(
      bottom: 10, // Moves it up to overlap the screen
      left: 20,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.orange : Colors.grey),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag, color: _selectedIndex == 1 ? Colors.orange : Colors.grey),
                label: 'Bag',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long, color: _selectedIndex == 2 ? Colors.orange : Colors.grey),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: _selectedIndex == 3 ? Colors.orange : Colors.grey),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  HomeScreenContent({required this.cart});

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> restaurants = [
    {'name': 'The Pizza Place', 'image': 'assets/images/pizza.jpeg', 'distance': '2km away', 'rating': 4.8},
    {'name': 'The Ice Cream Factory', 'image': 'assets/images/ice_cream.jpeg', 'distance': '1.2km away', 'rating': 4.7},
    {'name': 'Burger King', 'image': 'assets/images/burger.jpeg', 'distance': '2.3km away', 'rating': 4.5},
    {'name': 'The Coffee House', 'image': 'assets/images/coffee.jpeg', 'distance': '1.2km away', 'rating': 4.6},
  ];

  List<Map<String, dynamic>> filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    filteredRestaurants = List.from(restaurants);
  }

  void _filterRestaurants(String query) {
    setState(() {
      filteredRestaurants = restaurants.where((restaurant) {
        return restaurant['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(17.0).copyWith(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              onChanged: _filterRestaurants,
              decoration: InputDecoration(
                hintText: 'Search for a vendor ',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular Restaurants', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text('View all', style: TextStyle(color: Colors.orange)),
              ],
            ),
            SizedBox(height: 10),
            ...filteredRestaurants.map((restaurant) => _buildRestaurantCard(
              context,
              restaurant['name'],
              restaurant['image'],
              restaurant['distance'],
              restaurant['rating'],
            )).toList(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: Text('View all restaurants', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, String name, String imagePath, String distance, double rating) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(imagePath, width: double.infinity, height: 180, fit: BoxFit.cover),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: List.generate(5, (index) => Icon(index < rating ? Icons.star : Icons.star_border, color: Colors.orange, size: 16))),
                Text(distance, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            trailing: Transform.rotate(angle: -0.7854, child: CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.arrow_forward, color: Colors.white))),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen(restaurantName: name, cart: widget.cart)));
            },
          ),
        ],
      ),
    );
  }
}
