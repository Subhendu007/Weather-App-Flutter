import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onSubmited;
  final TextEditingController controller;
  final Function()? onLocPressed;
  final Function()? onSearchPressed;

  const CustomSearchBar(
      {Key? key,
      this.onSubmited,
      required this.controller,
      required this.onLocPressed,
      required this.onSearchPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        elevation: 5.0,
        child: TextField(
          onSubmitted: onSubmited,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            prefixIcon: IconButton(
              icon: Icon(Icons.my_location_rounded),
              onPressed: onLocPressed,
            ),
            hintText: "Search city",
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: onSearchPressed,
            ),
          ),
        ),
      ),
    );
  }
}
