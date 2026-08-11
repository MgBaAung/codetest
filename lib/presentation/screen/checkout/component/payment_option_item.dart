import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:flutter/material.dart';

enum SingingCharacter {
  paynow(name: "Pay Now"),
  credit(name: "Credit"),
  cod(name: "COD");

  final String name;
  const SingingCharacter({required this.name});
}

class PaymentOptionItem extends StatefulWidget {
  final void Function(SingingCharacter?) onChanged;
  final SingingCharacter character;

  const PaymentOptionItem({
    super.key,
    required this.onChanged,
    required this.character,
  });

  @override
  State<PaymentOptionItem> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<PaymentOptionItem> {
  @override
  Widget build(BuildContext context) {
    return RadioGroup<SingingCharacter>(
      groupValue: widget.character,
      onChanged: widget.onChanged,
      child: Row(
        children: <Widget>[
          Row(
            children: [
              Radio<SingingCharacter>(value: SingingCharacter.paynow),
              Text(SingingCharacter.paynow.name),
            ],
          ),
          10.boxWidth,
          Row(
            children: [
              Radio<SingingCharacter>(value: SingingCharacter.credit),
              Text(SingingCharacter.credit.name),
            ],
          ),
          10.boxWidth,
          Row(
            children: [
              Radio<SingingCharacter>(value: SingingCharacter.cod),
              Text(SingingCharacter.cod.name),
            ],
          ),
        ],
      ),
    );
  }
}
