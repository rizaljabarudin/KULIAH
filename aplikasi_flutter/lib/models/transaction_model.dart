import 'cart_item.dart';


class TransactionModel {
String id;
DateTime date;
double total;
List<CartItem> items;
TransactionModel({required this.id, required this.date, required this.total, required this.items});
}