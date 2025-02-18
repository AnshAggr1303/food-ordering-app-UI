import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order details', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text('The Pizza Place', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text('Out for delivery ...', style: TextStyle(fontSize: 18, color: Colors.white)),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer, color: Colors.white),
                            SizedBox(width: 5),
                            Text('10 mins', style: TextStyle(fontSize: 16, color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Your order is out for delivery. Monitor driver on the map',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset('assets/images/order_tracking_map.png'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Delivery address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('102nd St Ports, Maddison Heights, New York, USA', style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            Text('Order Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(),
            OrderItem(title: 'Kings Deal x1', description: 'Size: Large  Variant: BBQ Beef', price: 20.34),
            OrderItem(title: 'Salad x1', description: 'Greek-wedge', price: 20.34),
            OrderItem(title: 'Chicken Wings x1', description: '16pcs', price: 20.34),
            OrderItem(title: 'Soda', description: 'Coke', price: 20.34),
            Divider(),
            SizedBox(height: 10),
            Text('Payment method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.credit_card, color: Colors.orange),
                    SizedBox(width: 10),
                    Text('Bank Card'),
                  ],
                ),
                Text('ending with 3495'),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal'),
                Text('\$71.66'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery'),
                Text('\$12.00'),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$83.66', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => OrderTrackingScreen()),
                      (route) => false,
                );
              },
              child: Text('Order again', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('Need any assistance? Contact Support', style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String title;
  final String description;
  final double price;

  OrderItem({required this.title, required this.description, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 3),
        Text(description, style: TextStyle(fontSize: 14, color: Colors.grey)),
        SizedBox(height: 3),
        Text('\$${price.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
      ],
    );
  }
}
