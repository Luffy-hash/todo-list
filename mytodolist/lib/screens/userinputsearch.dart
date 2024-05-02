import 'package:flutter/material.dart';

class UserInputSearch extends StatefulWidget {
  UserInputSearch({super.key});

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  State<UserInputSearch> createState() => _UserInputSearchState();
}

class _UserInputSearchState extends State<UserInputSearch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Expanded(
          child: Row(
            
        children: [
        ],
      )),
    );
  }
}
