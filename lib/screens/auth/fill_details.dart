import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_page/core/component/widgets/responsive_screen.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/core/theme/app_icons.dart';
import 'package:college_page/core/theme/app_styles.dart';
import 'package:college_page/screens/auth/services/functions/authFunctions.dart';
import 'package:flutter/material.dart';

class FillDetailsScreen extends StatefulWidget {
  const FillDetailsScreen({Key? key, required this.email,required this.collegeSnapshot}) : super(key: key);

  final String email;
    final DocumentSnapshot collegeSnapshot;

  @override
  State<FillDetailsScreen> createState() => _FillDetailsScreenState();
}

class _FillDetailsScreenState extends State<FillDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _fullname = '';
  String _password = '';
  final bool _verify = false;
  final bool _status = false; 

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthServices.signupUser(widget.email, _password, _fullname,_verify, _status,widget.collegeSnapshot.id, context);
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
                                text: ' Complete Up 👇',
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
                          'Hey, Enter your details to complete \nyour account.',
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
                            'Full Name',
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
                            key: ValueKey(_fullname),
                            style: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.blueDarkColor,
                              fontSize: 12.0,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _fullname = value!;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Image.asset(AppIcons.emailIcon),
                              ),
                              contentPadding: const EdgeInsets.only(top: 16.0),
                              hintText: 'Enter Full Name',
                              hintStyle: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.blueDarkColor.withOpacity(0.5),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.014),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Password',
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
                            key: ValueKey(_password),
                            style: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.blueDarkColor,
                              fontSize: 12.0,
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Image.asset(AppIcons.eyeIcon),
                              ),
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Image.asset(AppIcons.lockIcon),
                              ),
                              contentPadding: const EdgeInsets.only(top: 16.0),
                              hintText: 'Enter Password',
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
                                'Confirm',
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
