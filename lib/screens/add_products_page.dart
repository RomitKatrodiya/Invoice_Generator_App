import 'package:flutter/material.dart';
import 'package:invoice_generator_app/resource/global.dart';

import '../resource/colors.dart';
import '../resource/global_style.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final GlobalKey<FormState> addProduct = GlobalKey<FormState>();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();

  String? productName;
  String? price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (addProduct.currentState!.validate()) {
            addProduct.currentState!.save();

            setState(() {
              Products p = Products.fromAdd(
                productName: productName.toString(),
                price: price.toString(),
              );

              Global.appProductsList.add(p);

              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/", (route) => false);
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
                "Enter Your Product Details",
                style: AppStyle.textStyle,
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: addProduct,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Product Name...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          productName = val;
                        },
                        controller: productNameController,
                        decoration: textFieldDecoration("Product Name"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Product Price...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          price = val;
                        },
                        keyboardType: TextInputType.number,
                        controller: productPriceController,
                        decoration:
                            textFieldDecoration("Product Price (with Tax)"),
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
