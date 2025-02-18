import 'package:food_ordering_app/models/ food_item.dart';


class Order {
  final String orderId;
  final List<FoodItem> items;
  final double totalAmount;
  final String status;

  Order({
    required this.orderId,
    required this.items,
    required this.totalAmount,
    required this.status,
  });
}
