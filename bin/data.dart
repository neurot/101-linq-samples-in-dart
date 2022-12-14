library linq_data;

import 'dart:io';
import 'dart:convert' as convert;
// import 'dart:json' as JSON;
// import 'dart:mirrors';

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

final customers = customersList();

class Product {
  final int productId;
  final String productName;
  final String category;
  final double unitPrice;
  final int unitsInStock;

  Product(this.productId, this.productName, this.category, this.unitPrice,
      this.unitsInStock);

  @override
  toString() => {
        'productId': productId,
        'productName': productName,
        'category': category,
        'unitPrice': unitPrice,
        'unitsInStock': unitsInStock
      }.toString();
}

class Order {
  int orderId;
  DateTime orderDate;
  double total;

  Order(this.orderId, this.orderDate, this.total);

  @override
  toString() =>
      {'orderId': orderId, 'orderDate': orderDate, 'total': total}.toString();
}

class Customer {
  String customerId;
  String companyName;
  String address;
  String city;
  String region;
  String postalCode;
  String country;
  String phone;
  String fax;
  List<dynamic> orders;

  @override
  toString() => "$customerId, $companyName -> ${orders.length} orders";

  Customer(
      [this.customerId = '',
      this.companyName = '',
      this.address = '',
      this.city = '',
      this.region = '',
      this.postalCode = '',
      this.country = '',
      this.phone = '',
      this.fax = ''])
      : orders = <dynamic>[];
}

List<Product> productsList() {
  var products = <Product>[
    Product(1, "Chai", "Beverages", 18.000, 39),
    Product(2, "Chang", "Beverages", 19.000, 17),
    Product(3, "Aniseed Syrup", "Condiments", 10.000, 13),
    Product(4, "Chef Anton's Cajun Seasoning", "Condiments", 22.000, 53),
    Product(5, "Chef Anton's Gumbo Mix", "Condiments", 21.350, 0),
    Product(6, "Grandma's Boysenberry Spread", "Condiments", 25.000, 120),
    Product(7, "Uncle Bob's Organic Dried Pears", "Produce", 30.000, 15),
    Product(8, "Northwoods Cranberry Sauce", "Condiments", 40.000, 6),
    Product(9, "Mishi Kobe Niku", "Meat/Poultry", 97.000, 29),
    Product(10, "Ikura", "Seafood", 31.000, 31),
    Product(11, "Queso Cabrales", "Dairy Products", 21.000, 22),
    Product(12, "Queso Manchego La Pastora", "Dairy Products", 38.000, 86),
    Product(13, "Konbu", "Seafood", 6.000, 24),
    Product(14, "Tofu", "Produce", 23.250, 35),
    Product(15, "Genen Shouyu", "Condiments", 15.500, 39),
    Product(16, "Pavlova", "Confections", 17.450, 29),
    Product(17, "Alice Mutton", "Meat/Poultry", 39.000, 0),
    Product(18, "Carnarvon Tigers", "Seafood", 62.500, 42),
    Product(19, "Teatime Chocolate Biscuits", "Confections", 9.200, 25),
    Product(20, "Sir Rodney's Marmalade", "Confections", 81.000, 40),
    Product(21, "Sir Rodney's Scones", "Confections", 10.000, 3),
    Product(22, "Gustaf's Kn??ckebr??d", "Grains/Cereals", 21.000, 104),
    Product(23, "Tunnbr??d", "Grains/Cereals", 9.000, 61),
    Product(24, "Guaran?? Fant??stica", "Beverages", 4.500, 20),
    Product(25, "NuNuCa Nu??-Nougat-Creme", "Confections", 14.000, 76),
    Product(26, "Gumb??r Gummib??rchen", "Confections", 31.230, 15),
    Product(27, "Schoggi Schokolade", "Confections", 43.900, 49),
    Product(28, "R??ssle Sauerkraut", "Produce", 45.600, 26),
    Product(29, "Th??ringer Rostbratwurst", "Meat/Poultry", 123.790, 0),
    Product(30, "Nord-Ost Matjeshering", "Seafood", 25.890, 10),
    Product(31, "Gorgonzola Telino", "Dairy Products", 12.500, 0),
    Product(32, "Mascarpone Fabioli", "Dairy Products", 32.000, 9),
    Product(33, "Geitost", "Dairy Products", 2.500, 112),
    Product(34, "Sasquatch Ale", "Beverages", 14.000, 111),
    Product(35, "Steeleye Stout", "Beverages", 18.000, 20),
    Product(36, "Inlagd Sill", "Seafood", 19.000, 112),
    Product(37, "Gravad lax", "Seafood", 26.000, 11),
    Product(38, "C??te de Blaye", "Beverages", 263.500, 17),
    Product(39, "Chartreuse verte", "Beverages", 18.000, 69),
    Product(40, "Boston Crab Meat", "Seafood", 18.400, 123),
    Product(41, "Jack's New England Clam Chowder", "Seafood", 9.650, 85),
    Product(42, "Singaporean Hokkien Fried Mee", "Grains/Cereals", 14.000, 26),
    Product(43, "Ipoh Coffee", "Beverages", 46.000, 17),
    Product(44, "Gula Malacca", "Condiments", 19.450, 27),
    Product(45, "Rogede sild", "Seafood", 9.500, 5),
    Product(46, "Spegesild", "Seafood", 12.000, 95),
    Product(47, "Zaanse koeken", "Confections", 9.500, 36),
    Product(48, "Chocolade", "Confections", 12.750, 15),
    Product(49, "Maxilaku", "Confections", 20.000, 10),
    Product(50, "Valkoinen suklaa", "Confections", 16.250, 65),
    Product(51, "Manjimup Dried Apples", "Produce", 53.000, 20),
    Product(52, "Filo Mix", "Grains/Cereals", 7.000, 38),
    Product(53, "Perth Pasties", "Meat/Poultry", 32.800, 0),
    Product(54, "Tourti??re", "Meat/Poultry", 7.450, 21),
    Product(55, "P??t?? chinois", "Meat/Poultry", 24.000, 115),
    Product(56, "Gnocchi di nonna Alice", "Grains/Cereals", 38.000, 21),
    Product(57, "Ravioli Angelo", "Grains/Cereals", 19.500, 36),
    Product(58, "Escargots de Bourgogne", "Seafood", 13.250, 62),
    Product(59, "Raclette Courdavault", "Dairy Products", 55.000, 79),
    Product(60, "Camembert Pierrot", "Dairy Products", 34.000, 19),
    Product(61, "Sirop d'??rable", "Condiments", 28.500, 113),
    Product(62, "Tarte au sucre", "Confections", 49.300, 17),
    Product(63, "Vegie-spread", "Condiments", 43.900, 24),
    Product(64, "Wimmers gute Semmelkn??del", "Grains/Cereals", 33.250, 22),
    Product(65, "Louisiana Fiery Hot Pepper Sauce", "Condiments", 21.050, 76),
    Product(66, "Louisiana Hot Spiced Okra", "Condiments", 17.000, 4),
    Product(67, "Laughing Lumberjack Lager", "Beverages", 14.000, 52),
    Product(68, "Scottish Longbreads", "Confections", 12.500, 6),
    Product(69, "Gudbrandsdalsost", "Dairy Products", 36.000, 26),
    Product(70, "Outback Lager", "Beverages", 15.000, 15),
    Product(71, "Flotemysost", "Dairy Products", 21.500, 26),
    Product(72, "Mozzarella di Giovanni", "Dairy Products", 34.800, 14),
    Product(73, "R??d Kaviar", "Seafood", 15.000, 101),
    Product(74, "Longlife Tofu", "Produce", 10.000, 4),
    Product(75, "Rh??nbr??u Klosterbier", "Beverages", 7.750, 125),
    Product(76, "Lakkalik????ri", "Beverages", 18.000, 57),
    Product(77, "Original Frankfurter gr??ne So??e", "Condiments", 13.000, 32)
  ];
  return products;
}

List<dynamic> _customers = <dynamic>[];
List<Customer> customersList() {
  var input = File('Customers.json').readAsStringSync();
  var mapCustomers = convert.jsonDecode(input);
  _customers = mapCustomers['customers']
      .map((c) => Customer(
          c['id'],
          c['name'],
          c['address'],
          c['city'],
          c['region'] ?? '',
          c['postalCode'] ?? '',
          c['country'],
          c['phone'],
          c['fax'] ?? '')
        ..orders = safe(safe(c['orders'])['order'], [])
            .map((o) => Order(int.parse(o['id']),
                DateTime.parse(o['orderdate']), double.parse(o['total'])))
            .toList())
      .toList();
  return List<Customer>.from(_customers);
}

dynamic safe(o, [orElse = const {}]) {
  return o ?? orElse;
}
// Future<List<Customer>> customersList() async {
//   var input = await File('Customers.json').readAsString();
//   var mapCustomers = convert.jsonDecode(input);
//   var customers = mapCustomers['customers']
//       .map((c) => Customer(
//           c['id'],
//           c['name'] ?? '',
//           c['address'] ?? '',
//           c['city'] ?? '',
//           c['region'] ?? '',
//           c['postalCode'] ?? '',
//           c['country'] ?? '',
//           c['phone'] ?? '',
//           c['fax'] ?? '')
//         ..orders = safe(safe(c['orders'])['order'], <Order>[])
//             .map((o) => Order(int.parse(o['id']),
//                 DateTime.parse(o['orderdate']), double.parse(o['total'])))
//             .toList())
//       .toList();
//   return customers;
// }

// safe(o, [orElse = const <Order>[]]) {
//   return o ?? orElse;
// }

// log(o){
//   print(o);
//   return o;
// }

// runSamples(String section, Map samplesMap){
// //  return printTOC(section, samplesMap);

//   var dashes = new String.fromCharCodes(new List.filled(section.length, '-'.codeUnits[0]));
//   print("\n\n$section\n$dashes");

//   var lib = currentMirrorSystem().findLibrary(const Symbol('linq_samples')).first;
//   samplesMap.forEach((fnName, desc){
//     var fn = lib.functions[new Symbol(fnName)];
//     print("\n\n### ${fnName}: $desc\n");
//     lib.invoke(new Symbol(fnName), []);
//   });
// }

// printTOC(String section, Map samplesMap){
//   print("\n### $section\n");

//   samplesMap.forEach((fnName, desc) =>
//     print("  - ${fnName}: $desc"));
// }
