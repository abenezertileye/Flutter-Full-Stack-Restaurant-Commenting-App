import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_review/application/bloc/restaurant_crud_bloc/restaurant_crud_bloc.dart';
import 'package:restaurant_review/application/bloc/restaurant_crud_bloc/restaurant_crud_event.dart';
import 'package:restaurant_review/domain/entities/update_restaurant_entity.dart';
import 'package:restaurant_review/presentation/widgets/modal_form_text_field.dart';

class UpdateModal extends StatefulWidget {
  const UpdateModal({Key? key}) : super(key: key);

  @override
  _UpdateModalState createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _closingHoursController = TextEditingController();
  final TextEditingController _openingHoursController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _closingHoursController.dispose();
    _openingHoursController.dispose();
    _descriptionController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _submitForm() {
    print("Edit submit pressed");
    final Map<String, dynamic> updates = {};
    print("cont ${_addressController.text}");

    if (_nameController.text.isNotEmpty) {
      updates['name'] = _nameController.text;
    }
    if (_addressController.text.isNotEmpty) {
      updates['location'] = _addressController.text;
    }
    if (_openingHoursController.text.isNotEmpty) {
      updates['openingTime'] = _openingHoursController.text;
    }
    if (_closingHoursController.text.isNotEmpty) {
      updates['closingTime'] = _closingHoursController.text;
    }
    if (_descriptionController.text.isNotEmpty) {
      updates['description'] = _descriptionController.text;
    }
    if (_contactController.text.isNotEmpty) {
      updates['contact'] = _contactController.text;
    }

    if (updates.isNotEmpty) {
      final restaurant = UpdateRestaurantDTO.fromJson(updates);
      print("res $restaurant");

      context.read<RestaurantCrudBloc>().add(UpdateRestaurantRequested(restaurant));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully updated restaurant details.')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No changes to update.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Contact information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFieldWLabel(
                  label: "Name",
                  required: true,
                  controller: _nameController,
                ),
                TextFieldWLabel(
                  label: "Address",
                  required: true,
                  controller: _addressController,
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Availableness',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                TextFieldWLabel(
                  label: "Opening hours",
                  required: true,
                  controller: _openingHoursController,
                ),
                TextFieldWLabel(
                  label: "Closing hours",
                  required: true,
                  controller: _closingHoursController,
                ),
                TextFieldWLabel(
                  label: "Contact number",
                  required: true,
                  controller: _contactController,
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                TextFieldWLabel(
                  label: "Description",
                  required: true,
                  controller: _descriptionController,
                ),
                const SizedBox(height: 10.0),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 245, 149, 24),
                      shadowColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
