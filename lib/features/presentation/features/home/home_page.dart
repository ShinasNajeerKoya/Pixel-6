import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/features/presentation/features/home/customer/customer_page.dart';
import 'package:pixel6_test/features/presentation/features/home/profile/profile_page.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  final String userLoginKey;

  const HomePage({Key? key, required this.userLoginKey}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _homepageValue = [];
  final bool _isLoading = false;
  final double initialValue = 100;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedTile = -1; // to keep track of selected tile

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.bars),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: CustomText(
                  title: "Menu",
                  fontSize: 25,
                ),
              ),
              DrawerButton(
                icon: CupertinoIcons.profile_circled,
                buttonTitle: "Profile",
                tileColor: selectedTile == 0 ? MyColors.drawerButtonBg : Colors.white,
                onTap: () {
                  setState(() {
                    selectedTile = 0;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        userLoginKey: widget.userLoginKey,
                      ),
                    ),
                  );
                },
              ),
              DrawerButton(
                icon: CupertinoIcons.person_2_alt,
                buttonTitle: "Customer",
                tileColor: selectedTile == 1 ? MyColors.drawerButtonBg : Colors.white,
                onTap: () {
                  setState(() {
                    selectedTile = 1;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerPage(),
                    ),
                  );
                },
              ),
              Spacer(),
              DrawerButton(
                icon: Icons.logout,
                buttonTitle: "Logout",
                tileColor: selectedTile == 5 ? MyColors.drawerButtonBg : Colors.white,
                onTap: () {
                  setState(() {
                    selectedTile = 5;
                  });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => LoginPage()
                  //   ),
                  // );
                  // sendLogoutNotification();
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _homepageValue.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Hello there, how was your day?'),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: const [
                    /* content will be moved to here if the api response is not empty*/
                  ],
                ),
    );
  }
//
}

class DrawerButton extends StatelessWidget {
  final IconData icon;
  final String buttonTitle;

  final Color tileColor;
  final void Function()? onTap;

  const DrawerButton({
    super.key,
    required this.icon,
    required this.buttonTitle,
    required this.tileColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(buttonTitle),
        tileColor: tileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: onTap,
      ),
    );
  }
}
