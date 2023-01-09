import 'package:flutter/material.dart';

class SelectStationButton extends StatefulWidget {
  final String buttonText;
  final Function(BuildContext) callbackAction;

  const SelectStationButton(this.buttonText, this.callbackAction, {super.key});

  @override
  State<SelectStationButton> createState() => _SelectStationButtonState();
}

class _SelectStationButtonState extends State<SelectStationButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.callbackAction(context),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(300, 60),
        backgroundColor: Colors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        alignment: Alignment.center,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.buttonText,
            style: const TextStyle(color: Colors.black87, fontSize: 20),
          ),
          const Icon(
            Icons.search_outlined,
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
