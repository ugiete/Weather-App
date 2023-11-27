import 'package:flutter/material.dart';

class SearchLocations extends StatefulWidget {
  const SearchLocations({super.key});

  @override
  State<SearchLocations> createState() => _SearchLocationsState();
}

class _SearchLocationsState extends State<SearchLocations> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        filled: true,
        fillColor: Colors.white24,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
          size: 20,
        ),
        hintText: 'Search city',
        hintStyle: const TextStyle(
          color: Colors.white
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
    );
  }
}