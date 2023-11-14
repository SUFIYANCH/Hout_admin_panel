import 'package:flutter/material.dart';
import 'package:hout_admin_panel/screens/admin/add_products_page.dart';
import 'package:hout_admin_panel/screens/admin/home_page.dart';
import 'package:hout_admin_panel/screens/admin/products_screen.dart';
import 'package:hout_admin_panel/screens/signup_screen.dart';
import 'package:hout_admin_panel/service/auth_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hout Admin'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.blue,
            selectedIndex: _selectedIndex,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedIconTheme: const IconThemeData(color: Colors.black),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            unselectedLabelTextStyle: const TextStyle(color: Colors.black),
            extended: true,
            onDestinationSelected: (int index) {
              if (index == 4) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Do you want to log out?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")),
                        TextButton(
                            onPressed: () async {
                              await AuthService().logout();
                            },
                            child: const Text("Yes")),
                      ],
                    );
                  },
                );
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add),
                label: Text('Add Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.explore),
                label: Text('All Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add),
                label: Text('Add User'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout),
                label: Text('Log Out'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: _buildPage(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return AddProductsPage();
      case 2:
        return ProductsScreen();
      case 3:
        return SignUpScreen();
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }
}
