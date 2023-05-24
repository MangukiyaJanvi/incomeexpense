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
  ReadTransactionController controller = Get.put(ReadTransactionController());
  int income = 0;
  int expance = 0;
  int total = 0;

  @override
  void initState() {
    super.initState();
    controller.readdata();
  }

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
                    "₹ ${controller.TotalIncomeList[0]['SUM(amount)'] -
                        controller.TotalExpanseList[0]['SUM(amount)']}",
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
                                "₹ ${controller.TotalExpanseList[0]['SUM(amount)']}",
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
                              "₹ ${controller.TotalIncomeList[0]['SUM(amount)']}",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                      () =>
                      ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            Obx(
                                  () =>
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        (controller
                                            .readTransactionList[index]['status'] ==
                                            0)
                                            ? Container(
                                          height: 40.sp,
                                          width: 50.sp,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade100,
                                            borderRadius: BorderRadius.circular(
                                                20),
                                          ),
                                          child: Icon(
                                            Icons.trending_down,
                                            color: Colors.red.shade900,
                                          ),
                                        )
                                            : Container(
                                          height: 40.sp,
                                          width: 50.sp,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius: BorderRadius.circular(
                                                20),
                                          ),
                                          child: Icon(
                                            Icons.trending_up_sharp,
                                            color: Colors.green.shade900,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                "${controller
                                                    .readTransactionList[index]['category']}",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  "${controller
                                                      .readTransactionList[index]['date']}"),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 10,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              (controller
                                                  .readTransactionList[index]
                                              ['status'] ==
                                                  0)
                                                  ? Text(
                                                "-${controller
                                                    .readTransactionList[index]['amount']}",
                                                style: TextStyle(
                                                    color: Colors.red.shade800,
                                                    fontSize: 18),
                                              )
                                                  : Text(
                                                "+${controller
                                                    .readTransactionList[index]['amount']}",
                                                style: TextStyle(
                                                    color: Colors.green
                                                        .shade800,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            ),
                        itemCount: controller.readTransactionList.length,
                      ),
                ),
              ),
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
                                  initialDate: controller.currentdate.value,
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
                                controller.setdate(date!);
                              },
                              child: Obx(
                                    () =>
                                    Text(
                                      "${controller.currentdate.value
                                          .year}/${controller.currentdate.value
                                          .month}/${controller.currentdate.value
                                          .day}",
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
                                initialTime: controller.currenttime.value,
                                builder: (context, child) =>
                                    MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!),
                              );
                              controller.currenttime.value = pickedtime!;
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
                                      "${controller.currenttime.value
                                          .hour}:${controller.currenttime.value
                                          .minute}",
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
                                                        controller.chageCate(
                                                            controller
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
                                                          "${controller
                                                              .categoryList[index]}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                      ),
                                                    ),
                                                itemCount:
                                                controller.categoryList.length,
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
                                              controller.categoryList
                                                  .add(txtCategory.text);
                                              print(controller.categoryList);
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
                                      "${controller.cate}",
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
                                        groupValue: controller.paymenttype
                                            .value,
                                        onChanged: (value) {
                                          setState(() {
                                            controller.changeType(value);
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
                                        groupValue: controller.paymenttype
                                            .value,
                                        onChanged: (value) {
                                          setState(() {
                                            controller.changeType(value);
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
                              controller.totalExpense =
                                  controller.totalExpense + expance;
                              setState(() {
                                total = total - expance;
                              });
                              var date =
                                  "${controller.currentdate.value
                                  .year}/${controller.currentdate.value
                                  .month}/${controller.currentdate.value.day}";
                              var time =
                                  "${controller.currenttime.value
                                  .hour}/${controller.currenttime.value
                                  .minute}";

                              controller.changeexpence();
                              DbHelper dbHelper = DbHelper();
                              dbHelper.insertData(
                                  category: controller.cate.value,
                                  notes: txtNote.text,
                                  status: 0,
                                  amount: txtAmount.text,
                                  paytypes: "${controller.paymenttype.value}",
                                  date: "${date}",
                                  time: "${time}");
                              controller.TotalExpanse();
                              controller.readdata();
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
                              controller.totalIncome =
                                  controller.totalIncome + income;
                              setState(() {
                                total = total + income;
                              });
                              var date =
                                  "${controller.currentdate.value
                                  .year}/${controller.currentdate.value
                                  .month}/${controller.currentdate.value.day}";
                              var time =
                                  "${controller.currenttime.value
                                  .hour}/${controller.currenttime.value
                                  .minute}";
                              controller.changeincome();
                              DbHelper dbHelper = DbHelper();
                              dbHelper.insertData(
                                  category: controller.cate.value,
                                  notes: txtNote.text,
                                  status: 1,
                                  amount: txtAmount.text,
                                  paytypes: "${controller.paymenttype.value}",
                                  date: "${date}",
                                  time: "${time}");
                              controller.TotalIncome();
                              controller.readdata();
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
                child: const Text(
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
