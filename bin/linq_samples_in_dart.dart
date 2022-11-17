// 101 LINQ samples in dart.

import 'data.dart';

const numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
const digits = [
  'zero',
  'one',
  'two',
  'three',
  'four',
  'five',
  'six',
  'seven',
  'eight',
  'nine'
];

Future<void> main() async {
  await restrictingOperators(); // aka where
  projectionOperators(); // aka select / map
}

Future<void> restrictingOperators() async {
// aka where
  whereSimple1();
  whereSimple2();
  whereSimple3();
  await whereSimple4();
  whereIndexed();
}

void projectionOperators() {
// aka select / map
  selectSimple1();
  selectSimple2();
  selectTransformation();
  selectAnonymousTypes();
}

void selectAnonymousTypes() {
  print('''

select anonymous types
----------------------
C#:
    string[] words = { "aPPLE", "BlUeBeRrY", "cHeRry" }; 
    var upperLowerWords = 
        from w in words 
        select new { Upper = w.ToUpper(), Lower = w.ToLower() }; 
''');

  const words = ['aPPLE', 'BlUeBeRrY', 'cHeRry'];
  final upperLowerWords =
      words.map((e) => {'Upper': e.toUpperCase(), 'Lower': e.toLowerCase()});
  for (var ul in upperLowerWords) {
    print('Uppercase: ${ul['Upper']}, Lowercase: ${ul['Lower']}');
  }
}

void selectTransformation() {
  print('''

select transformation
---------------------
C#:
    int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 }; 
    string[] strings = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" }; 
    var textNums = 
        from n in numbers 
        select strings[n]; 
''');

  final textNums = numbers.map((n) => digits[n]);
  print('Number strings:');
  textNums.forEach(print);
}

void selectSimple2() {
  print('''

select simple 2 
---------------
C#:
    List<Product> products = GetProductList(); 
    var productNames = 
        from p in products 
        select p.ProductName; 
''');

  final productNames = productsList().map((p) => p.productName);
  print('Product Names:');
  productNames.forEach(print);
}

void selectSimple1() {
  print('''

select simple 1 
---------------
C#:
    int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 }; 
    var numsPlusOne = 
        from n in numbers 
        select n + 1; 
''');

  final numsPlusOne = numbers.map((n) => n + 1);
  print('Numbers + 1');
  numsPlusOne.forEach(print);
}

void whereIndexed() {
  print('''

where indexed 
-------------
C#:

    string[] digits = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" }; 
    var shortDigits = digits.Where((digit, index) => digit.Length < index); 
''');

  int index = 0;
  final shortDigits = digits.where((digit) => digit.length < index++);

  print('Short digits:');
  for (final digit in shortDigits) {
    print('The word $digit is shorter than its value.');
  }
}

Future<void> whereSimple4() async {
  print('''

where simple 4 
--------------
C#:
    List<Customer> customers = GetCustomerList(); 
    var waCustomers = 
        from c in customers 
        where c.Region == "WA" 
        select c;
''');

  final waCustomers = await customersList()
      .then((customers) => customers.where((c) => c.region == "WA"));

  print('Customers from Washington and their orders:');
  for (final c in waCustomers) {
    print('Customer ${c.customerId}: ${c.companyName}');
    for (final o in c.orders) {
      print('   Order ${o.orderId}: ${o.orderDate}');
    }
  }
}

void whereSimple3() {
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

  final expensiveInStrockProducts =
      productsList().where((p) => p.unitsInStock > 0 && p.unitPrice > 3.00);

  print('In-stock products that cost more than 3.00:');
  for (final p in expensiveInStrockProducts) {
    print(
        '${p.productName} is in stock and costs more than 3.00 (${p.unitPrice})');
  }
}

void whereSimple2() {
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

  final soldOutProducts = productsList().where((p) => p.unitsInStock == 0);

  print('Sold out products:');
  for (final p in soldOutProducts) {
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

  final lowNums = numbers.where((n) => n < 5);

  print('Numbers < 5:');
  lowNums.forEach(print);
}
