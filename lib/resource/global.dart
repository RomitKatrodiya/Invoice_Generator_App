class Products {
  String? productName;
  String? price;

  Products({required this.productName, required this.price});

  factory Products.fromAdd(
      {required String productName, required String price}) {
    return Products(
      productName: productName,
      price: price,
    );
  }
}

class Customers {
  String? customerName;
  String? customerNumber;

  Customers({required this.customerName, required this.customerNumber});

  factory Customers.fromAdd(
      {required String customerName, required String customerNumber}) {
    return Customers(
      customerName: customerName,
      customerNumber: customerNumber,
    );
  }
}

class Global {
  static List<Products> appProductsList = [];
  static List<Customers> appCustomersList = [];

  // ignore: prefer_typing_uninitialized_variables
  static var image;
  static String? companyName;
  static String? companyAddress;
  static String? companyAddress2;
  static String? companyAddress3;
  static String? companyGSTNo;
  static String? companyNumber;
  static String? companyEmail;

  static List<int> totalList = [];
  static List<int> counter = [];

  static int? initialTaxValue;
  static int total = 0;
}
