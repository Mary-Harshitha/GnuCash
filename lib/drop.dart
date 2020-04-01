import 'package:flutter/material.dart';

class Drop extends StatefulWidget{
  _DropState createState() => _DropState();
}

class _DropState extends State<Drop>{

  List<String> typeNeg = [
    "One",
    "Two",
    "Three",];

  String dropdownValue = "One";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dropdown demo'),),
      body: Container(
        child: DropdownButtonFormField<String>(
          value: dropdownValue,
          hint: Text("Type of business"),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          validator: (String value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter a valid type of business';
            }
            return '';
          },
          items: typeNeg
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
//          onSaved: (val) => setState(() => _user.typeNeg = val),
//        ),
      ),)
    );
  }
}