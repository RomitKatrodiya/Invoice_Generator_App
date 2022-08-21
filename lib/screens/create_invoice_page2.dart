import 'package:flutter/material.dart';

import '../resource/colors.dart';
import '../resource/global.dart';
import '../resource/global_style.dart';

class CreateInvoicePage2 extends StatefulWidget {
  const CreateInvoicePage2({Key? key}) : super(key: key);

  @override
  State<CreateInvoicePage2> createState() => _CreateInvoicePage2State();
}

class _CreateInvoicePage2State extends State<CreateInvoicePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Generator"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Select Customer",
                style: AppStyle.textStyle,
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: Global.appCustomersList.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("pdf_page", arguments: i);
                  },
                  child: Card(
                    shape: const StadiumBorder(),
                    color: AppColors.primary.withOpacity(0.2),
                    elevation: 0,
                    child: ListTile(
                      leading: Text(
                        "${i + 1}",
                        style: AppStyle.textStyleProducts,
                      ),
                      title: Text(
                        "${Global.appCustomersList[i].customerName}",
                        style: AppStyle.textStyleProducts,
                      ),
                      trailing: Text(
                        "${Global.appCustomersList[i].customerNumber}",
                        style: AppStyle.textStyleProducts,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
