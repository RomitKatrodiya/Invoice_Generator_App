import 'package:flutter/material.dart';
import 'package:invoice_generator_app/resource/colors.dart';
import 'package:invoice_generator_app/resource/global.dart';

import '../resource/global_style.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final GlobalKey<FormState> addCustomer = GlobalKey<FormState>();

  final TextEditingController customerNumberController =
      TextEditingController();
  final TextEditingController customerNameController = TextEditingController();

  String? customerName;
  String? customerNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Customer"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (addCustomer.currentState!.validate()) {
            addCustomer.currentState!.save();

            setState(() {
              Customers c = Customers.fromAdd(
                customerName: customerName.toString(),
                customerNumber: customerNumber.toString(),
              );

              Global.appCustomersList.add(c);

              Navigator.of(context).pushNamedAndRemoveUntil(
                "customer_page",
                (route) => false,
              );
            });
          }
        },
        style: AppStyle.elevatedButtonStyle,
        child: const Text("ADD"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Your Customer Details",
                style: AppStyle.textStyle,
              ),
              Container(
                padding: const EdgeInsets.all(25),
                  child: Form(
                    key: addCustomer,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Customer Name...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            customerName = val;
                          },
                          controller: customerNameController,
                          decoration: textFieldDecoration("Customer Name."),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Customer Number...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            customerNumber = val;
                          },
                          keyboardType: TextInputType.number,
                          controller: customerNumberController,
                          decoration: textFieldDecoration("Customer Number"),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
