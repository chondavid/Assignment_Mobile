import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ManageAccountView extends StatelessWidget {
  const ManageAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //logout
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: Column(
                  children: [
                    Text(
                      'PhaNith',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'View profile',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              // Row for "Orders", "Favourites", "Payments", "Addresses"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAccountOption(Icons.receipt_long, 'Orders', () {
                    // Get.toNamed(Routes.MANAGE_ACCOUNT_ORDER);
                  }),
                  _buildAccountOption(Icons.favorite, 'Favourites', () {
                    Get.toNamed('/favourites');
                  }),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAccountOption(Icons.payment, 'Payments', () {
                    Get.toNamed('/payments');
                  }),
                  _buildAccountOption(Icons.location_on, 'Addresses', () {
                    Get.toNamed('/address');
                  }),
                ],
              ),
              SizedBox(height: 20),
              // Perks for you section
              Text(
                'Perks for you',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildListTile(Icons.star, 'Become a pro'),
              _buildListTile(Icons.card_giftcard, 'Vouchers'),
              _buildListTile(Icons.person_add, 'Invite friends'),
              SizedBox(height: 20),
              // General section
              Text(
                'General',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildListTile(Icons.help, 'Help center'),

              //logout button
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(color: Colors.black),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(color: Colors.black12),
                      ),
                      onPressed: () {
                        Get.offAllNamed('/login');
                      },
                      child: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountOption(IconData icon, String label, Function()? onTap) {
    return Expanded(
      child: MaterialButton(
        onPressed: onTap,
        child: Column(
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
