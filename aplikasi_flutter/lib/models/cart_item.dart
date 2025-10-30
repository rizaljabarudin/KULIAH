import 'alat_pancing.dart';

class CartItem {
  final AlatPancing product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}
