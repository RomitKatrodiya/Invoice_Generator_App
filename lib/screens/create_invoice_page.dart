import 'package:flutter/material.dart';

import '../resource/colors.dart';
import '../resource/global.dart';
import '../resource/global_style.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({Key? key}) : super(key: key);

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Global.total = 0;
      Global.counter = [];
      Global.totalList = [];
    });

    for (int i = 0; i < Global.appProductsList.length; i++) {
      setState(() {
        Global.counter.add(0);
        Global.totalList.add(0);
      });
    }
  }

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
                "Select Items",
                style: AppStyle.textStyle,
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: Global.appProductsList.length,
              itemBuilder: (context, i) {
                return Card(
                  shape: const StadiumBorder(),
                  color: AppColors.primary.withOpacity(0.2),
                  elevation: 0,
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "  ${i + 1}",
                          style: AppStyle.textStyleProducts,
                        ),
                      ],
                    ),
                    title: Text(
                      "${Global.appProductsList[i].productName}",
                      style: AppStyle.textStyleProducts,
                    ),
                    subtitle: Text(
                      " ₹ ${Global.appProductsList[i].price}",
                      style: AppStyle.textStyleProducts,
                    ),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            splashColor: AppColors.primary.withOpacity(0.4),
                            onPressed: () {
                              setState(() {
                                (Global.counter[i] == 0)
                                    ? Global.counter[i] = 0
                                    : Global.counter[i] = Global.counter[i] - 1;
                                Global.totalList[i] = Global.counter[i] *
                                    int.parse(
                                        "${Global.appProductsList[i].price}");
                                Global.total = 0;

                                // ignore: avoid_function_literals_in_foreach_calls
                                Global.totalList.forEach((element) {
                                  Global.total = Global.total + element;
                                });
                              });
                            },
                            icon: Icon(Icons.minimize,
                                size: 30, color: AppColors.primary),
                          ),
                          Text(
                            "${Global.counter[i]}",
                            style: AppStyle.textStyle,
                          ),
                          IconButton(
                            splashColor: AppColors.primary.withOpacity(0.4),
                            onPressed: () {
                              setState(() {
                                Global.counter[i] = Global.counter[i] + 1;
                                Global.totalList[i] = Global.counter[i] *
                                    int.parse(
                                        "${Global.appProductsList[i].price}");
                                Global.total = 0;

                                // ignore: avoid_function_literals_in_foreach_calls
                                Global.totalList.forEach((element) {
                                  Global.total = Global.total + element;
                                });
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.primary.withOpacity(0.2),
              child: Row(
                children: [
                  const Spacer(flex: 4),
                  Text(
                    "Total = ₹ ${Global.total}",
                    style: AppStyle.textStyle,
                  ),
                  const Spacer(flex: 4),
                  ElevatedButton(
                    onPressed: () {
                      if (Global.total != 0) {
                        Navigator.of(context).pushNamed("create_invoice_page2");
                      }
                    },
                    style: AppStyle.elevatedButtonStyle,
                    child: const Text("Next"),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
