import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incomeexpense/utils/db_helper.dart';

class ReadTransactionController extends GetxController {
  RxList<Map> readTransactionList = <Map>[].obs;

  Future<void> readdata() async {
    DbHelper dbHelper = DbHelper();
    readTransactionList.value = await dbHelper.readData();
  }

  void filterDataRead(int status) async {
    DbHelper dbHelper = DbHelper();
    readTransactionList.value = await dbHelper.filterRead(statusCode: status);
  }

  void allFilterReadData({fromDate, toDate, payTypes, status, category}) async {
    DbHelper dbHelper = DbHelper();
    readTransactionList.value =
        await dbHelper.allFilterRead(fromDate: fromDate, toDate: toDate);
  }

  void delete(int id) {
    DbHelper dbHelper = DbHelper();
    dbHelper.deleteData(id: id);
    readdata();
  }

  void updateData(
      {required id,
      required category,
      required notes,
      required status,
      required amount,
      required paytypes,
      required date,
      required time}) {
    DbHelper dbHelper = DbHelper();
    dbHelper.updateDate(
        id: id,
        category: category,
        notes: notes,
        status: status,
        amount: amount,
        paytypes: paytypes,
        date: date,
        time: time);
  }

  Rx<DateTime> currentdate = DateTime.now().obs;
  Rx<TimeOfDay> currenttime = TimeOfDay.now().obs;

  void setdate(DateTime date) {
    currentdate.value = date;
  }

  RxString paymenttype = "".obs;

  void changeType(value) {
    paymenttype.value = value;
  }

  RxInt totalIncome = 0.obs;
  RxInt totalExpense = 0.obs;
  RxInt bankBalance = 0.obs;

  void changeincome() {
    bankBalance = bankBalance + totalIncome.value;
  }

  void changeexpence() {
    bankBalance = bankBalance - totalExpense.value;
  }

  RxList categoryList = ["Salary", "Food", "Education"].obs;
  RxString cate = "Choose Category".obs;

  void chageCate(String category) {
    cate.value = category;
  }

  Rx<DateTime> fromeDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;
}
