import 'package:flutter/material.dart';

import 'colors.dart';
import 'global.dart';

class AppStyle {
  static var elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: AppColors.primary,
    shape: const StadiumBorder(),
  );

  static var outLinedButtonStyle = OutlinedButton.styleFrom(
    primary: AppColors.primary,
  );
  static var outLinedButtonStyle2 = OutlinedButton.styleFrom(
    primary: AppColors.primary,
    shape: const StadiumBorder(),
  );

  static var textStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static var textStyleProducts = TextStyle(
    color: AppColors.primary,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
}

textFieldDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    alignLabelWithHint: true,
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 1.5),
    ),
    hintStyle: TextStyle(
      color: AppColors.primary,
    ),
  );
}

invoiceOutlinedButton(context) {
  return OutlinedButton(
    onPressed: () {
      if (Global.companyName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: const Text(
              "Enter Company Details First...",
            ),
            action: SnackBarAction(
              onPressed: () {
                Navigator.of(context).pushNamed("add_details_page");
              },
              label: "OPEN",
              textColor: AppColors.primary,
            ),
          ),
        );
      } else if (Global.appProductsList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: const Text(
              "Add Product First...",
            ),
            action: SnackBarAction(
              onPressed: () {
                Navigator.of(context).pushNamed("add_products_page");
              },
              label: "ADD",
              textColor: AppColors.primary,
            ),
          ),
        );
      } else if (Global.appCustomersList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: const Text(
              "Add Customer First...",
            ),
            action: SnackBarAction(
              onPressed: () {
                Navigator.of(context).pushNamed("add_customer_page");
              },
              label: "ADD",
              textColor: AppColors.primary,
            ),
          ),
        );
      } else {
        Navigator.of(context).pushNamed("create_invoice_page");
      }
    },
    style: AppStyle.outLinedButtonStyle,
    child: Container(
      alignment: Alignment.center,
      height: double.infinity,
      child: const Text("Create\nInvoice"),
    ),
  );
}

willPop(context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(
        child: Text("Exit From App", style: AppStyle.textStyle),
      ),
      content:
          Text("Are you sure want to exit?", style: AppStyle.textStyleProducts),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: AppStyle.elevatedButtonStyle,
          child: const Text("Yes"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: AppStyle.outLinedButtonStyle2,
          child: const Text("No"),
        ),
      ],
    ),
  );
}
