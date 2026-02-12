import 'dart:developer';

import 'package:bookstore/Admin/Books/AddBook.dart';
import 'package:bookstore/Admin/Books/ShowBook.dart';
import 'package:bookstore/Admin/Categories/AddCategories.dart';
import 'package:bookstore/Admin/Categories/ShowCategories.dart';
import 'package:bookstore/Admin/Home.dart';
import 'package:bookstore/credentials/login.dart';
import 'package:bookstore/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Admin Panel'),
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int _expandedTileIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 40, 44, 51),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 80),
          children: [
            _buildDrawerItem(
              icon: Icons.home,
              text: 'Dashboard',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomeScreen()),
                );
              },
            ),
            _buildExpansionTile(
              index: 0,
              icon: CupertinoIcons.folder,
              title: 'Category  ',
              context: context,
              children: [
                _buildListTile('Add Category', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddCategory()),
                  );
                }),
                _buildListTile("View All Categories", onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Showcat()),
                  );
                }),
              ],
            ),
            _buildExpansionTile(
              index: 0,
              icon: CupertinoIcons.book,
              title: 'Book',
              context: context,
              children: [
                _buildListTile('Add Book', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddBook()),
                  );
                }),
                _buildListTile('View All Books', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShowBooks()),
                  );
                }),
              ],
            ),
           SizedBox(height: 50),
            _buildDrawerItem(
              icon: Icons.arrow_back,
              text: 'Back to User Panel',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Myhome()),
                );
              },
            ),
            SizedBox(
              height: 550,
            ),
            _buildDrawerItem(
              icon:CupertinoIcons.clear_thick_circled,
              text: 'Logout',
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile({
    required int index,
    required IconData icon,
    required String title,
    required List<Widget> children,
    required BuildContext context,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Material(
        color: Colors.transparent, // Avoid background overlay
        child: ExpansionTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          iconColor: Color.fromARGB(255, 255, 152, 0),
          collapsedIconColor: Colors.white,
          children: children,

          backgroundColor: Colors.transparent, // Transparent background
        ),
      ),
    );
  }

  Widget _buildListTile(String title, {required VoidCallback onTap}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 152, 0),
              fontWeight: FontWeight.w400,
              fontSize: 15 // Medium font weight
              ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
      ),
      tileColor: Colors.transparent, // Ensure no color overlay
      onTap: onTap,
    );
  }
}

// Function to handle logout
void logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => const Mylogin()), // Redirect to Login screen
  );
}
