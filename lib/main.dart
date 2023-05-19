import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incomeexpense/screens/expense_income/view/income_screen.dart';
import 'package:incomeexpense/screens/homescreen/view/home_screen.dart';
import 'package:incomeexpense/screens/read_transaction/view/read_transaction_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/',
            page: () => HomeScreen(),
          ),
          GetPage(
            name: '/income',
            page: () => IncomeScreen(),
          ),
          GetPage(
            name: '/read',
            page: () => ReadTransactionScreen(),
          ),
        ],
      ),
    ),
  );
}
