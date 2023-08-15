import 'package:college_page/screens/auth/services/functions/add_college_data.dart';
import 'package:flutter/material.dart';

class CollegeDataForm extends StatefulWidget {
  @override
  _CollegeDataFormState createState() => _CollegeDataFormState();
}

class _CollegeDataFormState extends State<CollegeDataForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String campusTour = '';
  String collegeName = '';
  String district = '';
  String domain = '';
  String state = 'Chhattisgarh';
  String websiteLink = '';
  String logo = '';
  String collegeunique_id = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AddData.addCollege(campusTour, collegeName, district, domain, logo, state,
          websiteLink,'', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Data Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'College Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter college name';
                  }
                  return null;
                },
                onSaved: (value) {
                  collegeName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'District'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter district';
                  }
                  return null;
                },
                onSaved: (value) {
                  district = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Domain'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter domain';
                  }
                  return null;
                },
                onSaved: (value) {
                  domain = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Logo Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter logo link';
                  }
                  return null;
                },
                onSaved: (value) {
                  logo = value!;
                },
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'State'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter state';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     state = value!;
              //   },
              // ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Website Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter website link';
                  }
                  return null;
                },
                onSaved: (value) {
                  websiteLink = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Campus Tour'),
                maxLines: 3,
                onSaved: (value) {
                  campusTour = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
