import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/features/presentation/features/home/customer/customer_listing/customer_listing_page.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(
          title: "Customers List",
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: MyColors.mainRedColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerListingPage()));
        },
      ),
    );
  }
}
