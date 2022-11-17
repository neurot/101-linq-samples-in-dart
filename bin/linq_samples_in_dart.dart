// 101 LINQ samples in dart.

import 'data.dart';

void main() {
  restrictingOperators();
}

void restrictingOperators() {
// Restriting Operators (aka where)
  whereSimple1();
  whereSimpe2();
  whereSimpe3();
}

void whereSimpe3() {
  print('''

where simple 3
--------------
C#:
List<Product> products = GetProductList(); 
var expensiveInStockProducts = 
  from p in products 
  where p.UnitsInStock > 0 && p.UnitPrice > 3.00M 
  select p; 
''');

  var products = productsList();
  var expensiveInStrockProducts =
      products.where((p) => p.unitsInStock > 0 && p.unitPrice > 3.00);

  print('In-stock products that cost more than 3.00:');
  for (var p in expensiveInStrockProducts) {
    print(
        '${p.productName} is in stock and costs more than 3.00 (${p.unitPrice})');
  }
}

void whereSimpe2() {
  print('''

where simple 2
--------------
C#:
List<Product> products = GetProductList();
var soldOutProducts =
  from p in products
  where p.UnitsInStock == 0
  select p;
''');

  var products = productsList();

  var soldOutProducts = products.where((p) => p.unitsInStock == 0);

  print('Sold out products:');
  for (var p in soldOutProducts) {
    print('${p.productName} is sold out!');
  }
}

void whereSimple1() {
  print('''

where simple 1
--------------
C#:
int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 };
var lowNums =
  from n in numbers
  where n < 5
  select n;
''');

  var numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
  var lowNums = numbers.where((n) => n < 5);

  print('Numbers < 5:');
  lowNums.forEach(print);
}
