import 'package:flutter/material.dart';
import 'package:invoice_generator_app/screens/add_customer_page.dart';
import 'package:invoice_generator_app/screens/add_details_page.dart';
import 'package:invoice_generator_app/screens/add_products_page.dart';
import 'package:invoice_generator_app/screens/create_invoice_page.dart';
import 'package:invoice_generator_app/screens/create_invoice_page2.dart';
import 'package:invoice_generator_app/screens/customer_page.dart';
import 'package:invoice_generator_app/screens/home_page.dart';
import 'package:invoice_generator_app/screens/pdf_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const HomePage(),
        "add_products_page": (context) => const AddProducts(),
        "add_customer_page": (context) => const AddCustomer(),
        "customer_page": (context) => const CustomerPage(),
        "add_details_page": (context) => const AddDetailsPage(),
        "create_invoice_page": (context) => const CreateInvoicePage(),
        "create_invoice_page2": (context) => const CreateInvoicePage2(),
        "pdf_page": (context) => const PdfPage(),
      },
    ),
  );
}
