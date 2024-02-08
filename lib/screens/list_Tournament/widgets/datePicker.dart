// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {
  DatePicker({super.key, required this.controller, required this.labeltxt});

  // ignore: prefer_typing_uninitialized_variables
  TextEditingController controller;
  String labeltxt;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        readOnly: true,
        decoration: InputDecoration(labelText: widget.labeltxt),
        onTap: () async {
          DateTime? picked = await showDatePicker(
              context: context,
              //  initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100));
          if (picked != null) {
            final formatDate =
                //DateFormat('dd-MM-yyyy').format(picked);
                DateFormat.yMMMMd('en_US').format(picked);
            setState(() {
              widget.controller.text = formatDate.toString();
            });
          }
        });
  }
}