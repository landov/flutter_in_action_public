import 'package:flutter/material.dart';
import 'package:weather_app/models/src/countries.dart';


class CountryDropdownField extends StatelessWidget {
  final Function onChanged;
  final Country? country;

  const CountryDropdownField({
    super.key,
    required this.onChanged,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Country",
        ),
        value: country ?? Country.AD,
        onChanged: (Country? newSelection) => onChanged(newSelection),
        items: Country.ALL.map((Country country) {
          return DropdownMenuItem(value: country, child: Text(country.name));
        }).toList(),
      ),
    );
  }
}