import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/models/src/app_settings.dart';
import 'package:weather_app/styles.dart';
import 'package:weather_app/widget/country_dropdown_field.dart';

class AddNewCityPage extends StatefulWidget {
  final AppSettings settings;

  const AddNewCityPage({super.key, required this.settings});

  @override
  State<AddNewCityPage> createState() => _AddNewCityPageState();
}

class _AddNewCityPageState extends State<AddNewCityPage> {
  City _newCity = City.fromUserInput();
  bool _formChanged = false;
  bool _isDefaultFlag = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // clean up the focus node when this page is destroyed.
    focusNode.dispose();
    super.dispose();
  }

  bool validateTextFields() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add City",
          style: TextStyle(color: AppColor.textColorLight),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          onChanged: _onFormChange,
          onWillPop: _onWillPop,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  onSaved: (String? val) => _newCity.name = val,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    helperText: "Required",
                    labelText: "City name",
                  ),
                  autofocus: true,
                  autovalidateMode: _formChanged
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  validator: (String? val) {
                    if (val == null || val.isEmpty)
                      return "Field cannot be left blank";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  focusNode: focusNode,
                  onSaved: (String? val) => print(val),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    helperText: "Optional",
                    labelText: "State or Territory name",
                  ),
                  validator: (String? val) {
                    if (val == null || val.isEmpty) {
                      return "Field cannot be left blank";
                    }
                    return null;
                  },
                ),
              ),
              CountryDropdownField(
                country: _newCity.country,
                onChanged: (newSelection) {
                  setState(() => _newCity.country = newSelection);
                },
              ),
              FormField(
                onSaved: (val) => _newCity.active = _isDefaultFlag,
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Default city?"),
                      Checkbox(
                        value: _isDefaultFlag,
                        onChanged: (val) {
                          setState(() => _isDefaultFlag = val ?? false);
                        },
                      ),
                    ],
                  );
                },
              ),
              Divider(
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        //TODO textColor
                        //textColor: Colors.red[400],
                        child: Text("Cancel"),
                        onPressed: () async {
                          if (await _onWillPop()) {
                            Navigator.of(context).pop(false);
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      //TODO color
                      //color: Colors.blue[400],
                      child: Text("Submit"),
                      onPressed: _formChanged
                          ? () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState!.save();
                                _handleAddNewCity();
                                Navigator.pop(context);
                              } else {
                                FocusScope.of(context).requestFocus(focusNode);
                              }
                            }
                          : null,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }

  void _handleAddNewCity() {
    final city = City(
      name: _newCity.name,
      country: _newCity.country,
      active: true,
    );

    allAddedCities.add(city);
  }

  Future<bool> _onWillPop() async {
    if (!_formChanged) return Future<bool>.value(true);
    final pop = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
              "Are you sure you want to abandon the form? Any changes will be lost."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text("Abandon"),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
    return pop ?? true;
  }
}
