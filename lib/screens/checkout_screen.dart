import 'package:flutter/material.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final double totalAmount;

  CheckoutScreen({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address Section
            Text('Deliver to:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                width: 70, // ⬆ Increased from 50 to 70
                height: 70, // ⬆ Increased from 50 to 70
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/images/location_placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text('Amelia Cassin', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('102nd St Ports, New York\n458-419-7182'),
              trailing: Icon(Icons.keyboard_arrow_down),
            ),

            SizedBox(height: 20),

            // Payment Method Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text('Add payment method', style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bank Card', style: TextStyle(fontSize: 16)),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Payment Card Image (Increased Size)
            Center(
              child: Image.asset(
                'assets/images/card_placeholder.png',
                height: 250, // ⬆ Increased from 150 to 200
              ),
            ),

            Spacer(),

            // Total Price & Confirm Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total to pay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderConfirmationScreen()),
                );
              },
              child: Text('Confirm Order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
