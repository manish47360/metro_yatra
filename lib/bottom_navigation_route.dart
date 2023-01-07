import 'package:flutter/material.dart';

class BottomNavigationRoute extends StatelessWidget {
  const BottomNavigationRoute(
      {Key? key,
      required this.nextPageName,
      required this.routeName,
      required this.icon})
      : super(key: key);
  final String nextPageName;
  final String routeName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, nextPageName),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            Text(
              routeName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
