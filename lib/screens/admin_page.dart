import 'package:flutter/material.dart';
import 'package:hout_admin_panel/screens/add_products_page.dart';
import 'package:hout_admin_panel/screens/home_page.dart';
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
            backgroundColor: Colors.amber,
            selectedIndex: _selectedIndex,
            extended: true,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
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
        return const Center(child: Text('Cart Page'));
      case 3:
        return Center(
            child: ElevatedButton(
                onPressed: () async {
                  await AuthService().logout();
                },
                child: const Text('Log Out')));
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }
}
