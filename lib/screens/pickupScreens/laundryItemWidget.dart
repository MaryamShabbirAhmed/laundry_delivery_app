class LaundryItem {
  final int id;
  final String name;
  final int pricePerItem;
  int quantity;

  LaundryItem({
    required this.id,
    required this.name,
    required this.pricePerItem,
    this.quantity = 0,
  });
}
