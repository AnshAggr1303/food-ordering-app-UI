import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Profile Title
              Center(
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              // Profile Image
              Center(
                child: CircleAvatar(
                  radius: 60, // ⬆ Increased size
                  backgroundImage: AssetImage('assets/images/profile_picture.jpeg'),
                ),
              ),
              SizedBox(height: 15),
              // User Details
              Text(
                'Ansh Agrawal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '102nd St Ports, New York',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                '458-419-7182',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 25),
              // Profile Options
              _buildProfileOption(Icons.credit_card, 'Payment methods', '2 cards added'),
              _buildProfileOption(Icons.home, 'Delivery address', '102nd St Ports, New York'),
              _buildProfileOption(Icons.settings, 'Settings', 'Notification | FAQ | Contact'),
              Spacer(),
              // Floating Logout Button
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.red.withOpacity(0.2),
                  elevation: 0,
                  onPressed: () {
                    // Handle logout action
                  },
                  child: Icon(Icons.logout, color: Colors.red),
                ),
              ),
              SizedBox(height: 135),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // Profile Option ListTile
  Widget _buildProfileOption(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey)),
      onTap: () {},
    );
  }

  // Custom Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return Container(
      margin: EdgeInsets.all(16), // Adds margin for floating effect
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Bag'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.orange), label: 'Profile'),
          ],
          currentIndex: 3,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      ),
    );
  }
}
