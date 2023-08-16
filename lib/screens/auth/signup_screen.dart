import 'dart:math';

import 'package:college_page/core/component/widgets/responsive_screen.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/core/theme/app_icons.dart';
import 'package:college_page/core/theme/app_styles.dart';
import 'package:college_page/screens/auth/fill_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  String email = '';

  Future<bool> checkIfEmailExists(String domain) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('colleges')
          .where("domain", isEqualTo: domain)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('College not listed')));
      return false;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      List<String> epart = email.split('@');

      bool emailExists = await checkIfEmailExists(epart[1]);



      if (emailExists) {
        // College email exists, perform login logic here

        QuerySnapshot collegesSnapshot = await FirebaseFirestore.instance.collection('colleges')
        .where('domain', isEqualTo: epart[1])
        .get();
DocumentSnapshot collegeSnapshot = collegesSnapshot.docs.first;


        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FillDetailsScreen(collegeSnapshot: collegeSnapshot, email: email,)));
        print('College Exist In Our Collection');
      } else {
        //College email does not exist
       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('College not found in list')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.backColor,
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: height,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ResponsiveScreen.isMobile(context)
                  ? const SizedBox()
                  : Expanded(
                      child: Container(
                        height: height,
                        color: AppColor.mainBlueColor,
                        child: Center(
                          child: Text(
                            'College Page',
                            style: ralewayStyle.copyWith(
                              fontSize: 48.0,
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
              Expanded(
                child: Container(
                  height: height,
                  margin: EdgeInsets.symmetric(
                      horizontal: ResponsiveScreen.isMobile(context)
                          ? height * 0.032
                          : height * 0.12),
                  color: AppColor.backColor,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.2),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Let’s',
                                  style: ralewayStyle.copyWith(
                                    fontSize: 25.0,
                                    color: AppColor.blueDarkColor,
                                    fontWeight: FontWeight.normal,
                                  )),
                              TextSpan(
                                text: ' Sign Up 👇',
                                style: ralewayStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.blueDarkColor,
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          'Hey, Enter your details to create \nyour account.',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textColor,
                          ),
                        ),
                        SizedBox(height: height * 0.064),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'College Email',
                            style: ralewayStyle.copyWith(
                              fontSize: 12.0,
                              color: AppColor.blueDarkColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          height: 50.0,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: AppColor.whiteColor,
                          ),
                          child: TextFormField(
                            key: ValueKey(email),
                            controller: _emailController,
                            style: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.blueDarkColor,
                              fontSize: 12.0,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email = value!;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Image.asset(AppIcons.emailIcon),
                              ),
                              contentPadding: const EdgeInsets.only(top: 16.0),
                              hintText: 'Enter Email',
                              hintStyle: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.blueDarkColor.withOpacity(0.5),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/login');
                            },
                            child: Text(
                              'Sign In',
                              style: ralewayStyle.copyWith(
                                fontSize: 12.0,
                                color: AppColor.mainBlueColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _submitForm,
                            borderRadius: BorderRadius.circular(16.0),
                            child: Ink(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70.0, vertical: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: AppColor.mainBlueColor,
                              ),
                              child: Text(
                                'Continue',
                                style: ralewayStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.whiteColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
