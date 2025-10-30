class Product {
int? id; // local DB id
String uuid; // persistent id
String name;
String description;
double price;
int stock;
String? imagePath; // local path or url


Product({
this.id,
required this.uuid,
required this.name,
required this.description,
required this.price,
required this.stock,
this.imagePath,
});


Map<String, dynamic> toMap() {
return {
'id': id,
'uuid': uuid,
'name': name,
'description': description,
'price': price,
'stock': stock,
'imagePath': imagePath,
};
}


factory Product.fromMap(Map<String, dynamic> m) => Product(
id: m['id'],
uuid: m['uuid'],
name: m['name'],
description: m['description'],
price: (m['price'] as num).toDouble(),
stock: m['stock'],
imagePath: m['imagePath'],
);
}