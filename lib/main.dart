import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel6_test/data/service/notification_service.dart';
import 'package:pixel6_test/presentation/features/customer/customers_listing/customers_listing_page.dart';

void main() async {
  await NotificationService.initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      // home: HomePage(
      //   userLoginKey: "one",
      // ),

      home: const CustomersListingPage(),
    );
  }
}
