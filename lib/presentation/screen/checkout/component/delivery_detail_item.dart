import 'package:flutter/material.dart';

class DeliveryDetailItem extends StatelessWidget {
  const DeliveryDetailItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Address:", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("No.12, Insein Rd, Yangon"),
      ],
    );
  }
}
