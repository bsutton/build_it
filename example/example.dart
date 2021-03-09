import 'example_objects.g.dart';

void main() {
  final categories = _json.map((e) => Category.fromJson(e));
  for (final category in categories) {
    print('Category: ${category.name}');
    for (final product in category.products) {
      print('  Product: ${product.name}');
    }
  }
}

final _json = [
  {
    'id': 1,
    'name': 'Intel CPU',
    'products': [
      {'id': 1, 'name': 'Celeron'},
      {'id': 1, 'name': 'Pentium'},
      {'id': 1, 'name': 'Core i3'},
      {'id': 1, 'name': 'Core i5'},
      {'id': 1, 'name': 'Core i7'},
    ]
  },
  {
    'id': 2,
    'name': 'AMD CPU',
    'products': [
      {'id': 1, 'name': 'Sempron'},
      {'id': 1, 'name': 'Athlon'},
      {'id': 1, 'name': 'Phenom'},
      {'id': 1, 'name': 'Opteron'},
    ]
  }
];
