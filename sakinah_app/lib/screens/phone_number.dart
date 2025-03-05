// ignore_for_file: use_build_context_synchronously, use_super_parameters

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sakinah_app/constants/constant.dart';
import 'package:sakinah_app/controller/auth.dart';
import 'package:sakinah_app/helper/navigation.dart';
import 'package:sakinah_app/screens/profile_details.dart';


class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _phoneContoller = TextEditingController();
  final TextEditingController _otpContoller = TextEditingController();
  bool isLoading = false; // Add this boolean variable
  bool isChecked = false; // Add this boolean variable


  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Register With Phone Number",
                        style: customGoogleFontStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _phoneContoller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefix: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/flag.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(" +234")
                                ],
                              ),
                              // prefixText: "+234 ",
                              labelText: "Enter your phone number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value!.length != 10) {
                                return "Invalid phone number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                                child: const Text(
                                  'I agree to the Terms and Conditions',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    isChecked) {
                                  // Proceed with OTP
                                  setState(() {
                                    isLoading = true; // Set loading to true
                                  });

                                  AuthService.sentOtp(
                                    phone: _phoneContoller.text,
                                    errorStep: () {
                                      setState(() {
                                        isLoading =
                                            false; // Set loading to false on error
                                      });

                                      //notify.OtpError();
                                    },
                                    nextStep: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("OTP Verification"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Enter 6 digit OTP"),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Form(
                                                key: _formKey1,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _otpContoller,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        "Enter your phone number",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.length != 6) {
                                                      return "Invalid OTP";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                if (_formKey1.currentState!
                                                    .validate()) {
                                                  AuthService.loginWithOtp(
                                                    otp: _otpContoller.text,
                                                  ).then((value) async {
                                                    if (value == "Success") {
                                                     
                                                      // Get account type after successful login
                                                      // String? accountType =
                                                      //     await AuthService
                                                      //         .getAccountType();
                                                      Navigator.pop(context);
                                                      changeScreenReplacement(context, ProfileDetailsScreen());
                                                      // switch (accountType) {
                                                      //   case "User":
                                                      //     changeScreenReplacement(
                                                      //         context,
                                                      //          Container());
                                                      //     break;

                                                       
                                                        

                                                       
                                                      // }
                                                      } else {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            value,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    }
                                                  });
                                                }
                                              },
                                              child: const Text("Submit"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  // Validation failed, set loading to false
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (!isChecked) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please accept the Terms and Conditions',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: COLOR_CUSTOM,
                                foregroundColor: Colors.white,
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Sign In",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
