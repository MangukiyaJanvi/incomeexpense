import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incomeexpense/screens/read_transaction/controller/read_transaction_controller.dart';
import 'package:sizer/sizer.dart';

class ReadTransactionScreen extends StatefulWidget {
  const ReadTransactionScreen({Key? key}) : super(key: key);

  @override
  State<ReadTransactionScreen> createState() => _ReadTransactionScreenState();
}

class _ReadTransactionScreenState extends State<ReadTransactionScreen> {
  ReadTransactionController controller = Get.put(ReadTransactionController());

  @override
  void initState() {
    super.initState();
    controller.readdata();
  }

  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtNote = TextEditingController();
  int income = 0;
  int expance = 0;
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        controller.readdata();
                      },
                      child: Text(
                        "All",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.filterDataRead(1);
                      },
                      child: Column(
                        children: [
                          Text(
                            "Income",
                            style: TextStyle(
                                color: Colors.green.shade900, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.filterDataRead(0);
                      },
                      child: Text(
                        "Expense",
                        style:
                            TextStyle(color: Colors.red.shade900, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Add Filter",
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () async {
                                        DateTime? date = await showDatePicker(
                                          context: context,
                                          initialDate:
                                              controller.fromeDate.value,
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2030),
                                          builder: (context, child) => Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                    primary: Color(0XFF1E2140),
                                                    onPrimary: Colors.white,
                                                    onSurface: Colors.black),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: Color(0XFF1E2140),
                                                  ),
                                                ),
                                              ),
                                              child: child!),
                                        );
                                        controller.fromeDate.value = date!;
                                      },
                                      child: Obx(
                                        () => Text(
                                          "${controller.fromeDate.value.year}-${controller.fromeDate.value.month}-${controller.fromeDate.value.day}",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () async {
                                        DateTime? date = await showDatePicker(
                                          context: context,
                                          initialDate: controller.toDate.value,
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2030),
                                          builder: (context, child) => Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                    primary: Color(0XFF1E2140),
                                                    onPrimary: Colors.white,
                                                    onSurface: Colors.black),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: Color(0XFF1E2140),
                                                  ),
                                                ),
                                              ),
                                              child: child!),
                                        );
                                        controller.toDate.value = date!;
                                        var from =
                                            "${controller.fromeDate.value.year}/${controller.fromeDate.value.month}/${controller.fromeDate.value.day}";
                                        var to =
                                            "${controller.toDate.value.year}/${controller.toDate.value.month}/${controller.toDate.value.day}";
                                        controller.allFilterReadData(
                                            fromDate: from, toDate: to);
                                        Get.back();
                                      },
                                      child: Obx(
                                        () => Text(
                                          "${controller.toDate.value.year}-${controller.toDate.value.month}-${controller.toDate.value.day}",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 18),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        controller.allFilterReadData(
                                            payTypes: "online");
                                        Get.back();
                                      },
                                      child: Text(
                                        "Online",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        controller.allFilterReadData(
                                            payTypes: "cash");
                                        Get.back();
                                      },
                                      child: Text(
                                        "Cash",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.filter_alt_outlined)),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) => Obx(
                        () => InkWell(
                          onTap: () {
                            var id =
                                controller.readTransactionList[index]['id'];
                            txtNote = TextEditingController(
                                text:
                                    "${controller.readTransactionList[index]['notes']}");
                            txtAmount = TextEditingController(
                                text:
                                    "${controller.readTransactionList[index]['amount']}");
                            BottomSheetDialog(id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    (controller.readTransactionList[index]
                                                ['status'] ==
                                            0)
                                        ? Container(
                                            height: 40.sp,
                                            width: 70.sp,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade200,
                                              border: Border.all(
                                                color: Color(0XFF1E2140),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              "Expance",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0XFF1E2140)),
                                            ))
                                        : Container(
                                            height: 40.sp,
                                            width: 70.sp,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade200,
                                              border: Border.all(
                                                color: Color(0XFF1E2140),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              "Income",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0XFF1E2140)),
                                            ),
                                          ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 40.sp,
                                      width: 70.sp,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0XFF1E2140),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "${controller.readTransactionList[index]['paytypes']}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white60),
                                      ),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      width: 10,
                                    )),
                                    IconButton(
                                      onPressed: () {
                                        var id = controller
                                            .readTransactionList[index]['id'];
                                        controller.delete(id);
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.readTransactionList[index]['category']}",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                              "${controller.readTransactionList[index]['notes']}"),
                                        ],
                                      ),
                                    ),
                                    Text(
                                        "${controller.readTransactionList[index]['date']}"),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (controller.readTransactionList[index]
                                                      ['status'] ==
                                                  0)
                                              ? Text(
                                                  "-${controller.readTransactionList[index]['amount']}",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 18),
                                                )
                                              : Text(
                                                  "+${controller.readTransactionList[index]['amount']}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 18),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: controller.readTransactionList.length,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future BottomSheetDialog(id) {
    return Get.bottomSheet(
      BottomSheet(
        backgroundColor: Colors.grey.shade100,
        onClosing: () {
          ReadTransactionScreen();
        },
        builder: (context) => Column(
          children: [
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
                        margin: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                        child: TextButton(
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: controller.currentdate.value,
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2030),
                              builder: (context, child) => Theme(
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
                            () => Text(
                              "${controller.currentdate.value.year}-${controller.currentdate.value.month}-${controller.currentdate.value.day}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 18),
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
                        margin: EdgeInsets.only(right: 5, bottom: 5, left: 5),
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
                            builder: (context, child) => MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
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
                            () => Text(
                              "${controller.currenttime.value.hour}:${controller.currenttime.value.minute}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 18),
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
                        margin: EdgeInsets.only(right: 5, bottom: 5, left: 5),
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 300.sp,
                                    child: Obx(
                                      () => GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2),
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            controller.chageCate(
                                                controller.categoryList[index]);
                                            Get.back();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 50,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Color(0XFF1E2140),
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${controller.categoryList[index]}",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                            () => Text(
                              "${controller.cate}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 18),
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
                        margin: EdgeInsets.only(right: 5, bottom: 5, left: 5),
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
                        margin: EdgeInsets.only(right: 5, bottom: 5, left: 5),
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
                          () => Column(
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
                                groupValue: controller.paymenttype.value,
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
                                groupValue: controller.paymenttype.value,
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
                        margin: EdgeInsets.only(right: 5, bottom: 5, left: 5),
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
                          var date =
                              "${controller.currentdate.value.year}/${controller.currentdate.value.month}/${controller.currentdate.value.day}";
                          var time =
                              "${controller.currenttime.value.hour}/${controller.currenttime.value.minute}";
                          controller.updateData(
                              id: id,
                              category: controller.cate.value,
                              notes: txtNote.text,
                              status: 0,
                              amount: txtAmount.text,
                              paytypes: "${controller.paymenttype.value}",
                              date: "${date}",
                              time: "${time}");
                          controller.readdata();
                          Get.back();
                        },
                        child: Text("Add Expence"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          var date =
                              "${controller.currentdate.value.year}/${controller.currentdate.value.month}/${controller.currentdate.value.day}";
                          var time =
                              "${controller.currenttime.value.hour}/${controller.currenttime.value.minute}";

                          controller.updateData(
                              id: id,
                              category: controller.cate.value,
                              notes: txtNote.text,
                              status: 1,
                              amount: txtAmount.text,
                              paytypes: "${controller.paymenttype.value}",
                              date: "${date}",
                              time: "${time}");
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
}
