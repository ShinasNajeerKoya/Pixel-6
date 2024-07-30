import 'package:flutter/cupertino.dart';
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
        title: const CustomText(
          title: "Customers List",
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [MyCustomerTile()],
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

class MyCustomerTile extends StatelessWidget {
  const MyCustomerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: MyColors.mainRedColor.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: "Full Name",
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                  title: "Pan Number: 555555",
                  fontSize: 14,
                  fontColor: Colors.grey.shade700,
                  letterSpacing: 2,
                ),
                CustomText(
                  title: "Email: dsjhjds@gmail.com",
                  fontSize: 14,
                  fontColor: Colors.grey.shade700,
                  letterSpacing: 2,
                ),
                CustomText(
                  title: "Phone: 5566445566",
                  fontSize: 14,
                  fontColor: Colors.grey.shade700,
                  letterSpacing: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                  title: "Address:",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                CustomText(
                  title: "Address L1: ddhjnjwhywe jhd",
                  fontSize: 14,
                  fontColor: Colors.grey.shade700,
                  letterSpacing: 2,
                ),
                CustomText(
                  title: "PostCode: 55669988",
                  fontSize: 14,
                  fontColor: Colors.grey.shade700,
                  letterSpacing: 2,
                ),
                CustomText(
                  title: "City: Kunjal",
                  fontSize: 14,
                  fontColor: Colors.grey.shade700,
                  letterSpacing: 2,
                ),
                CustomText(
                  title: "State: Karnataka",
                  fontSize: 14,
                  fontColor: Colors.grey.shade700,
                  letterSpacing: 2,
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.pencil)),
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bin_xmark)),
            ],
          )
        ],
      ),
    );
  }
}
