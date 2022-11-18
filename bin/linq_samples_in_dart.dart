// 101 LINQ samples in dart.

import 'data.dart';

Future<void> main() async {
  await restrictingOperators(); // aka where
  projectionOperators(); // aka select / map
}

Future<void> restrictingOperators() async {
// aka where
  whereSimple1();
  whereSimple2();
  whereSimple3();
  whereSimple4();
  whereIndexed();
}

void projectionOperators() {
// aka select / map
  selectSimple1();
  selectSimple2();
  selectTransformation();
  selectAnonymousTypes1();
  selectAnonymousTypes2();
  selectAnonymousTypes3();
  selectIndexed();
  selectFiltered();
  selectManyCompoundFrom1();
  selectManyCompoundFrom2();
  selectManyCompoundFrom3();
  selectManyFromAssignment();
  selectManyMultipleFrom();
  selectManyIndexed();
}

void selectManyIndexed() {
  print('''

019 select many multiple from 
-----------------------------
C#:
    List<Customer> customers = GetCustomerList(); 
    var customerOrders = 
        customers.SelectMany( 
            (cust, custIndex) => 
            cust.Orders.Select(o => "Customer #" + (custIndex + 1) + 
                                    " has an order with OrderID " + o.OrderID)); 
''');

  int custIndex = 0;
  final customerOrders = customers.expand((cust) {
    custIndex++;
    return cust.orders.map(
        (o) => 'Customer #$custIndex has an order with OrderId ${o.orderId}');
  });

  customerOrders.forEach(print);
}

void selectManyMultipleFrom() {
  print('''

018 select many multiple from 
-----------------------------
C#:
    List<Customer> customers = GetCustomerList(); 
    DateTime cutoffDate = new DateTime(1997, 1, 1); 
    var orders = 
        from c in customers 
        where c.Region == "WA" 
        from o in c.Orders 
        where o.OrderDate >= cutoffDate 
        select new { c.CustomerID, o.OrderID }; 
''');

  final cutoffDate = DateTime(1997, 1, 1);
  final orders = customers.where((c) => c.region == 'WA').expand((c) => c.orders
      .where((o) => o.orderDate.isAfter(cutoffDate))
      .map((o) => {
            'CustomerId': c.customerId,
            'OrderId': o.orderId,
            'OrderDate': o.orderDate
          }));

  print('Orders from regino Washington after $cutoffDate');
  orders.forEach(print);
}

void selectManyFromAssignment() {
  print('''

017 select many from assignment 
-------------------------------
C#:
    List<Customer> customers = GetCustomerList(); 
    var orders = 
        from c in customers 
        from o in c.Orders 
        where o.Total >= 2000.0M 
        select new { c.CustomerID, o.OrderID, o.Total }; 
''');

  final orders = customers.expand((c) => c.orders
      .where((o) => o.total >= 2000)
      .map((o) => {
            'CustomerId': c.customerId,
            'OrderId': o.orderId,
            'Total': o.total
          }));

  orders.forEach(print);
}

Future<void> selectManyCompoundFrom3() async {
  print('''

016 select many compound from 3 
-------------------------------
C#:
    List<Customer> customers = GetCustomerList(); 
    var orders = 
        from c in customers 
        from o in c.Orders 
        where o.OrderDate >= new DateTime(1998, 1, 1) 
        select new { c.CustomerID, o.OrderID, o.OrderDate }; 
''');

  final orders = customers.expand((c) => c.orders
      .where((o) => o.orderDate.isAfter(DateTime(1998, 1, 1)))
      .map((o) => {
            'CustomerId': c.customerId,
            'OrderId': o.orderId,
            'OrderDate': o.orderDate
          }));

  orders.forEach(print);
}

void selectManyCompoundFrom2() {
  print('''

015 select many compound from 2 
-------------------------------
C#:
    List<Customer> customers = GetCustomerList(); 
    var orders = 
        from c in customers 
        from o in c.Orders 
        where o.Total < 500.00M 
        select new { c.CustomerID, o.OrderID, o.Total }; 
''');

  final orders = customers.expand((c) => c.orders
      .where((o) => o.total < 500)
      .map((e) => {
            'CustomerId': c.customerId,
            'OrderId': e.orderId,
            'Total': e.total
          }));

  orders.forEach(print);
}

void selectManyCompoundFrom1() {
  print('''

014 select many compound from 1 
-------------------------------
C#:
    int[] numbersA = { 0, 2, 4, 5, 6, 8, 9 }; 
    int[] numbersB = { 1, 3, 5, 7, 8 }; 
    var pairs = 
        from a in numbersA 
        from b in numbersB 
        where a < b 
        select new { a, b }; 
''');

  const numbersA = [0, 2, 4, 5, 6, 8, 9];
  const numbersB = [1, 3, 5, 7, 8];
  final pairs = numbersA
      .expand((a) => numbersB.where((b) => a < b).map((b) => {'a': a, 'b': b}));

  print('Pairs where a < b:');
  for (final pair in pairs) {
    print('${pair['a']} is less than ${pair['b']}');
  }
}

void selectFiltered() {
  print('''

013 select filtered 
-------------------
C#:
    int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 }; 
    string[] digits = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" }; 
    var lowNums = 
        from n in numbers 
        where n < 5 
        select digits[n]; 

''');

  final lowNums = numbers.where((n) => n < 5).map((e) => digits[e]);

  print('Numbers < 5:');
  lowNums.forEach(print);
}

void selectIndexed() {
  print('''

012 select indexed 
------------------
C#:
    int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 }; 
    var numsInPlace = numbers.Select((num, index) => new { Num = num, InPlace = (num == index) }); 
''');

  int index = 0;
  final numsInPlace = numbers.map((n) => {'Num': n, 'InPlace': (n == index++)});

  print('Numver: In-place?');
  for (final n in numsInPlace) {
    print('${n['Num']}: ${n['InPlace']}');
  }
}

void selectAnonymousTypes3() {
  print('''

011 select anonymous types 3
----------------------------
C#:
    List<Product> products = GetProductList(); 
    var productInfos = 
        from p in products 
        select new { p.ProductName, p.Category, Price = p.UnitPrice }; 
''');

  final productInfos = productsList().map((p) => {
        'ProductName': p.productName,
        'Category': p.category,
        'Price': p.unitPrice
      });

  print('Product Info:');
  for (final p in productInfos) {
    print(
        '${p['ProductName']} is in the category ${p['Category']} and costs ${p['Price']} per unit.');
  }
}

void selectAnonymousTypes2() {
  print('''

010 select anonymous types 2
----------------------------
C#:
    int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 }; 
    string[] strings = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" }; 
    var digitOddEvens = 
        from n in numbers 
        select new { Digit = strings[n], Even = (n % 2 == 0) }; 
''');

  final digitOddEvens =
      numbers.map((n) => {'Digit': digits[n], 'Even': (n % 2 == 0)});

  for (final d in digitOddEvens) {
    print("The digit ${d['Digit']} is ${d['Even'] == true ? 'even' : 'odd'}.");
  }
}

void selectAnonymousTypes1() {
  print('''

009 select anonymous types 1
----------------------------
C#:
    string[] words = { "aPPLE", "BlUeBeRrY", "cHeRry" }; 
    var upperLowerWords = 
        from w in words 
        select new { Upper = w.ToUpper(), Lower = w.ToLower() }; 
''');

  const words = ['aPPLE', 'BlUeBeRrY', 'cHeRry'];
  final upperLowerWords =
      words.map((e) => {'Upper': e.toUpperCase(), 'Lower': e.toLowerCase()});
  for (final ul in upperLowerWords) {
    print('Uppercase: ${ul['Upper']}, Lowercase: ${ul['Lower']}');
  }
}

void selectTransformation() {
  print('''

008 select transformation
-------------------------
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

007 select simple 2 
-------------------
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

006 select simple 1 
-------------------
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

005 where indexed 
-----------------
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

void whereSimple4() {
  print('''

004 where simple 4 
------------------
C#:
    List<Customer> customers = GetCustomerList(); 
    var waCustomers = 
        from c in customers 
        where c.Region == "WA" 
        select c;
''');

  final waCustomers = customers.where((c) => c.region == "WA");

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

003 where simple 3
------------------
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

002 where simple 2
------------------
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

001 where simple 1
------------------
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
