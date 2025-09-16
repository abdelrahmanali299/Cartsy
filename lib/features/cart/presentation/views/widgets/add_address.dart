import 'dart:convert';

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/core/widgets/custom_button.dart';
import 'package:fake_store/core/widgets/custom_form_text_field.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';

class AddAddress extends StatefulWidget {
  final void Function(AddressModel address) onAddressSelected;
  const AddAddress({super.key, required this.onAddressSelected});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> with TickerProviderStateMixin {
  String? countryValue;
  String? stateValue;
  String? cityValue;
  AddressModel address = AddressModel();
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _offsetAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0), weight: 1),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (countryValue != null &&
        stateValue != null &&
        cityValue != null &&
        address.street != null) {
      widget.onAddressSelected(address);
    } else {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_offsetAnimation.value, 0),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // علشان ياخد أقل مساحة
          children: [
            Text(
              "Add Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// CSC Picker
            CSCPicker(
              dropdownItemStyle: TextStyle(color: Colors.blue),

              showStates: true,
              showCities: true,
              flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
              countrySearchPlaceholder: "Search Country",

              stateSearchPlaceholder: "Search State",
              citySearchPlaceholder: "Search City",
              countryDropdownLabel: "Country",
              stateDropdownLabel: "State",
              cityDropdownLabel: "City",

              onCountryChanged: (value) {
                address.country = value;
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                address.state = value;
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged: (value) {
                address.city = value;
                setState(() {
                  cityValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomFormTextField(
              hintText: 'Street Name',
              onChanged: (p0) {
                address.street = p0;
              },
            ),
            const SizedBox(height: 20),

            CustomButton(title: 'Confirm', onPressed: _validateAndSubmit),
          ],
        ),
      ),
    );
  }
}
