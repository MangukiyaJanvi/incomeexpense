import 'package:flutter/material.dart';
import 'package:incomeexpense/screens/expense_income/view/income_screen.dart';
import '../../read_transaction/view/read_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Color(0XFF1E2140),
            title: Text(
              "Money Manager",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
            bottom: TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                text: "Home",
              ),
              Tab(
                text: "Transaction",
              ),
            ]),
          ),
          body: TabBarView(children: [
            IncomeScreen(),
            ReadTransactionScreen(),
          ]),
        ),
      ),
    );
  }
}
