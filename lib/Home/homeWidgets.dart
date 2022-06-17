import 'package:flutter/material.dart';

class HomeWidgets {
  buildCards({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Function function,
  }) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width / 2 - 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 3.0,
              spreadRadius: 3.0,
              color: Colors.grey.shade200,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.blue,
                size: 40,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
