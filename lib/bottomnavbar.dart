
import 'package:flutter/material.dart';



class Mybottomnavbar extends StatefulWidget {
  const Mybottomnavbar({super.key});

  @override
  State<Mybottomnavbar> createState() => _MybottomnavbarState();
}

class _MybottomnavbarState extends State<Mybottomnavbar> {
    int _selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
      items: const [
 BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Product",
            ),
            BottomNavigationBarItem(

              
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "Profile",
            ),

   
      ],
      
               currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
      );
  }
}