import 'package:flutter/material.dart';

class UserInputSearch extends StatelessWidget {
  const UserInputSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Expanded(
          child: Row(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: "Rechercher"),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.search),
          )
        ],
      )),
    );
  }
}
