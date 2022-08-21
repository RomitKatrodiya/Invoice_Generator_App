import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resource/colors.dart';
import '../resource/global.dart';
import '../resource/global_style.dart';

class AddDetailsPage extends StatefulWidget {
  const AddDetailsPage({Key? key}) : super(key: key);

  @override
  State<AddDetailsPage> createState() => _AddDetailsPageState();
}

class _AddDetailsPageState extends State<AddDetailsPage> {
  final GlobalKey<FormState> addCompanyDetails = GlobalKey<FormState>();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyAddressController =
      TextEditingController();
  final TextEditingController companyAddress2Controller =
      TextEditingController();
  final TextEditingController companyAddress3Controller =
      TextEditingController();
  final TextEditingController companyGSTNoController = TextEditingController();
  final TextEditingController companyEmailController = TextEditingController();
  final TextEditingController companyNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Global.companyName != null) {
      companyNameController.text = Global.companyName.toString();
      companyAddressController.text = Global.companyAddress.toString();
      companyAddress2Controller.text = Global.companyAddress2.toString();
      companyAddress3Controller.text = Global.companyAddress3.toString();
      companyGSTNoController.text = Global.companyGSTNo.toString();
      companyEmailController.text = Global.companyEmail.toString();
      companyNumberController.text = Global.companyNumber.toString();
    }
  }

  final ImagePicker _picker = ImagePicker();

  dynamic image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Details"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (addCompanyDetails.currentState!.validate()) {
            addCompanyDetails.currentState!.save();

            if (image == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: const Text(
                    "Select image First...",
                  ),
                  action: SnackBarAction(
                    onPressed: () {
                      imageAddElevatedButton();
                    },
                    label: "ADD",
                    textColor: AppColors.primary,
                  ),
                ),
              );
            } else {
              setState(() {
                Global.image = image;
              });
              Navigator.of(context).pop();
            }
          }
        },
        style: AppStyle.elevatedButtonStyle,
        child: const Text("Save"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "Enter Your Company Details",
                style: AppStyle.textStyle,
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    backgroundImage: (image != null) ? FileImage(image!) : null,
                    child: (image != null)
                        ? const Text("")
                        : Text(
                            textAlign: TextAlign.center,
                            "Company\nLogo",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.primary,
                            ),
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      imageAddElevatedButton();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: addCompanyDetails,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Company Name...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.companyName = val;
                        },
                        controller: companyNameController,
                        decoration: textFieldDecoration("Company Name."),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Company Address...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.companyAddress = val;
                        },
                        controller: companyAddressController,
                        decoration: textFieldDecoration(
                            "Address (Street, Building No)"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Company Address Line 2...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.companyAddress2 = val;
                        },
                        controller: companyAddress2Controller,
                        decoration: textFieldDecoration("Address Line 2"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Company Address Line 3...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.companyAddress3 = val;
                        },
                        controller: companyAddress3Controller,
                        decoration: textFieldDecoration("Address Line 3"),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<int>(
                        hint: const Text("Select Tax Percentage"),
                        items: const [
                          DropdownMenuItem(
                            value: 5,
                            child: Text("Tax : 5%"),
                          ),
                          DropdownMenuItem(
                            value: 12,
                            child: Text("Tax : 12%"),
                          ),
                          DropdownMenuItem(
                            value: 18,
                            child: Text("Tax : 18%"),
                          ),
                          DropdownMenuItem(
                            value: 28,
                            child: Text("Tax : 28%"),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primary, width: 1.5),
                          ),
                        ),
                        validator: (val) {
                          if (val == null) {
                            return "Select Tax Percentage First...";
                          }
                          return null;
                        },
                        value: Global.initialTaxValue,
                        onChanged: (val) {
                          setState(() {
                            Global.initialTaxValue = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Company GST No...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.companyGSTNo = val;
                        },
                        controller: companyGSTNoController,
                        decoration: textFieldDecoration("Company GST No"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Company Phone Number...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.companyNumber = val;
                        },
                        keyboardType: TextInputType.phone,
                        controller: companyNumberController,
                        decoration: textFieldDecoration("Company Phone Number"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Company Email...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.companyEmail = val;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: companyEmailController,
                        decoration: textFieldDecoration("Company Email"),
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

  imageAddElevatedButton() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "When You go to pick Image ?",
          style: AppStyle.textStyleProducts,
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              XFile? pickerFile =
                  await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                image = File(pickerFile!.path);
                Navigator.of(context).pop();
              });
            },
            style: AppStyle.outLinedButtonStyle2,
            child: const Text("gallery"),
          ),
          OutlinedButton(
            onPressed: () async {
              XFile? pickerFile =
                  await _picker.pickImage(source: ImageSource.camera);
              setState(() {
                image = File(pickerFile!.path);
                Navigator.of(context).pop();
              });
            },
            style: AppStyle.outLinedButtonStyle2,
            child: const Text("Camera"),
          ),
        ],
      ),
    );
  }
}
