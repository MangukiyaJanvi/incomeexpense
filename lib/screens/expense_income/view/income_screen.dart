import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incomeexpense/utils/db_helper.dart';
import 'package:sizer/sizer.dart';

import '../../read_transaction/controller/read_transaction_controller.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtNote = TextEditingController();
  ReadTransactionController incomeController =
  Get.put(ReadTransactionController());
  int income = 0;
  int expance = 0;
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BottomSheetDialog();
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0XFF1E2140),
        ),
        body: Column(
          children: [
            Container(
              height: 100.sp,
              width: double.infinity,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "YOUR BANKBALANCE",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "₹ ${incomeController.bankBalance}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100.sp,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "YOUR EXPENSE",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                              () =>
                              Text(
                                "₹ ${incomeController.totalExpense}",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100.sp,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "YOUR INCOME",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() =>
                            Text(
                              "₹ ${incomeController.totalIncome}",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future BottomSheetDialog() {
    return Get.bottomSheet(
      BottomSheet(
        backgroundColor: Colors.grey.shade100,
        onClosing: () {},
        builder: (context) =>
            Column(
              children: [
                Container(
                  color: Colors.grey.shade500,
                  height: 30.sp,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction Details",
                        style: TextStyle(fontSize: 16),
                      ),
                      InkWell(
                          onTap: () {
                            InfoDialoag();
                          },
                          child: Icon(Icons.help_outline)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 45.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Date",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 45.sp,
                            width: 207.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                right: 5, top: 5, bottom: 5),
                            child: TextButton(
                              onPressed: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: incomeController.currentdate
                                      .value,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2030),
                                  builder: (context, child) =>
                                      Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                                primary: Color(0XFF1E2140),
                                                onPrimary: Colors.white,
                                                onSurface: Colors.black),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Color(0XFF1E2140),
                                              ),
                                            ),
                                          ),
                                          child: child!),
                                );
                                incomeController.setdate(date!);
                              },
                              child: Obx(
                                    () =>
                                    Text(
                                      "${incomeController.currentdate.value
                                          .year}/${incomeController.currentdate
                                          .value.month}/${incomeController
                                          .currentdate.value.day}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 18),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 45.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                right: 5, bottom: 5, left: 5),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Time",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? pickedtime = await showTimePicker(
                                context: context,
                                initialTime: incomeController.currenttime.value,
                                builder: (context, child) =>
                                    MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!),
                              );
                              incomeController.currenttime.value = pickedtime!;
                            },
                            child: Container(
                              height: 45.sp,
                              width: 207.sp,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5, bottom: 5),
                              padding: EdgeInsets.all(15),
                              child: Obx(
                                    () =>
                                    Text(
                                      "${incomeController.currenttime.value
                                          .hour}:${incomeController.currenttime
                                          .value.minute}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 18),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 45.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                right: 5, bottom: 5, left: 5),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: "Choose Category",
                                backgroundColor: Colors.white,
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 250.sp,
                                        child: Obx(
                                              () =>
                                              GridView.builder(
                                                gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: 2),
                                                itemBuilder: (context, index) =>
                                                    InkWell(
                                                      onTap: () {
                                                        incomeController
                                                            .chageCate(
                                                            incomeController
                                                                .categoryList[index]);
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 50,
                                                        padding: EdgeInsets.all(
                                                            10),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                              0XFF1E2140),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                        ),
                                                        alignment: Alignment
                                                            .center,
                                                        child: Text(
                                                          "${incomeController
                                                              .categoryList[index]}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                      ),
                                                    ),
                                                itemCount: incomeController
                                                    .categoryList.length,
                                              ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 200,
                                            child: TextFormField(
                                              controller: txtCategory,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          FloatingActionButton(
                                            onPressed: () {
                                              incomeController.categoryList
                                                  .add(txtCategory.text);
                                              print(incomeController
                                                  .categoryList);
                                            },
                                            backgroundColor: Color(0XFF1E2140),
                                            child: Icon(Icons.done),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 45.sp,
                              width: 207.sp,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5, bottom: 5),
                              padding: EdgeInsets.all(15),
                              child: Obx(
                                    () =>
                                    Text(
                                      "${incomeController.cate}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 18),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 45.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                right: 5, bottom: 5, left: 5),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Amount",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 45.sp,
                            width: 207.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.only(right: 5, bottom: 5),
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: txtAmount,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 110.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                right: 5, bottom: 5, left: 5),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Payment Type",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Container(
                            width: 207.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.only(right: 5, bottom: 5),
                            padding: EdgeInsets.all(10),
                            child: Obx(
                                  () =>
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RadioListTile(
                                        title: Text(
                                          "Cash",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 18),
                                        ),
                                        value: "cash",
                                        groupValue: incomeController.paymenttype
                                            .value,
                                        onChanged: (value) {
                                          setState(() {
                                            incomeController.changeType(value);
                                            // print("Cash");
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: Text(
                                          "Online",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 18),
                                        ),
                                        value: "online",
                                        groupValue: incomeController.paymenttype
                                            .value,
                                        onChanged: (value) {
                                          setState(() {
                                            incomeController.changeType(value);
                                            // print("Online");
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 45.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                right: 5, bottom: 5, left: 5),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Note",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 45.sp,
                            width: 207.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.only(right: 5, bottom: 5),
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: txtNote,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              expance = int.parse(txtAmount.text);
                              incomeController.totalExpense =
                                  incomeController.totalExpense + expance;
                              setState(() {
                                total = total - expance;
                              });
                              var date = "${incomeController.currentdate.value
                                  .day}/${incomeController.currentdate.value
                                  .month}/${incomeController.currentdate.value
                                  .year}";
                              var time="${incomeController.currenttime.value.hour}/${incomeController.currenttime.value.minute}";

                              incomeController.changeexpence();
                              DbHelper dbHelper = DbHelper();
                              dbHelper.insertData(
                                  category: incomeController.cate.value,
                                  notes: txtNote.text,
                                  status: 0,
                                  amount: txtAmount.text,
                                  paytypes: "${incomeController.paymenttype
                                      .value}",
                                  date: "${date}",
                                  time: "${time}");
                              Get.back();
                            },
                            child: Text("Add Expence"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors
                                  .red),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              income = int.parse(txtAmount.text);
                              incomeController.totalIncome =
                                  incomeController.totalIncome + income;
                              setState(() {
                                total = total + income;
                              });
                              var date = "${incomeController.currentdate.value
                                  .year}/${incomeController.currentdate.value
                                  .month}/${incomeController.currentdate.value
                                  .day}";
                              var time="${incomeController.currenttime.value.hour}/${incomeController.currenttime.value.minute}";
                              incomeController.changeincome();
                              DbHelper dbHelper = DbHelper();
                              dbHelper.insertData(
                                  category: incomeController.cate.value,
                                  notes: txtNote.text,
                                  status: 1,
                                  amount: txtAmount.text,
                                  paytypes: "${incomeController.paymenttype
                                      .value}",
                                  date: "${date}",
                                  time: "${time}");
                              Get.back();
                            },
                            child: Text("Add Income"),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll(Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Future InfoDialoag() {
    return Get.defaultDialog(
      title: "Info",
      content: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "These details are required to be entered : \n",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            ),
            Text(
              "Date : \nThe date the Transaction occurred.\n",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            ),
            Text(
              "Category : \nThe Category the Transaction falls into e.g. Clothes,Salary\n",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            ),
            Text(
              "Amount : \nThe monetary amount.\n\n",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "CLOSE",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
