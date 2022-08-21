import 'package:flutter/material.dart';

import '../resource/colors.dart';
import '../resource/global.dart';
import '../resource/global_style.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await willPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("add_details_page");
            },
            icon: const Icon(Icons.account_circle, size: 27),
          ),
          title: const Text("Invoice Generator"),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: const Text(""),
                  title: Text("Customer Name", style: AppStyle.textStyle),
                  trailing: Text("Number", style: AppStyle.textStyle),
                ),
              ),
            ),
            Expanded(
              flex: 28,
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: (Global.appCustomersList.isEmpty)
                        ? Column(
                            children: [
                              const SizedBox(height: 50),
                              Icon(
                                Icons.supervised_user_circle_outlined,
                                color: AppColors.primary.withOpacity(0.7),
                                size: 70,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "You don't have any Customer",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary.withOpacity(0.7),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: Global.appCustomersList.length,
                            itemBuilder: (context, i) {
                              return Card(
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
                              );
                            },
                          ),
                  ),
                  Container(
                    alignment: const Alignment(0, 1.07),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("add_customer_page");
                      },
                      style: AppStyle.elevatedButtonStyle,
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("/", (route) => false);
                      },
                      style: AppStyle.outLinedButtonStyle,
                      child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        child: const Text("Products"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: AppStyle.outLinedButtonStyle,
                      child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        child: const Text("Customers"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: invoiceOutlinedButton(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
