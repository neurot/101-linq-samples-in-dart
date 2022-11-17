// 101 LINQ samples in dart.

import 'data.dart';

void main() {
  restrictingOperators();
}

void restrictingOperators() {
// Restriting Operators (aka where)
  whereSimple1();
  whereSimpe2();
}

void whereSimpe2() {
// List<Product> products = GetProductList();

// var soldOutProducts =
//   from p in products
//   where p.UnitsInStock == 0
//   select p;

  var products = productsList();

  var soldOutProducts = products.where((product) => product.unitsInStock == 0);

  print('Sold out products:');
  for (var p in soldOutProducts) {
    print('${p.productName} is sold out!');
  }

  print('');
}

void whereSimple1() {
// int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 };
// var lowNums =
//   from n in numbers
//   where n < 5
//   select n;

  var numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
  var lowNums = numbers.where((element) => element < 5);

  print('Numbers < 5:');
  lowNums.forEach(print);

  print('');
}
