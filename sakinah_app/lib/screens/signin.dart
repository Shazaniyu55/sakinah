import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sakinah_app/constants/constant.dart';
import 'package:sakinah_app/controller/auth.dart';
import 'package:sakinah_app/helper/navigation.dart';
import 'package:sakinah_app/screens/phone_number.dart';
import 'package:sakinah_app/widget/bottomRectangularbtn.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

void handleGoogleSignIn() async {
  UserCredential? userCredential = await AuthService.signInWithGoogle();
  if (userCredential != null) {
    print("Google Sign-In Successful: ${userCredential.user?.displayName}");
  } else {
    print("Google Sign-In Failed");
  }
}



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.only(
                left: 29.0,
                right: 29.0,
              ), child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
          Center(
            child: Container(
                   
              margin: EdgeInsets.all(140),
              child: Column(
                children: [
                  Image.asset("images/logo.png", width: 50, height: 50,),
                  const SizedBox(height: 70,),
                  Text("Sign Up To Continue"),
                  const SizedBox(height: 20,),
  
                // BottomRectangularBtn(onTapFunc: ()=>{
                //   handleGoogleSignIn()
                // }, btnTitle: "Continue with email"),
         const SizedBox(height: 20,),
        
                BottomRectangularBtn(onTapFunc: ()=>{changeScreen(context, PhoneAuthScreen())}, btnTitle: "Use phone number", color: Colors.white, buttonTextColor: COLOR_CUSTOM,),
        const SizedBox(height: 30,),
        
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('or sign up with'),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
        
        
        const SizedBox(height: 50,),
        
                // Social Media Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(icon: Icons.facebook, onTap: () {}),
                    const SizedBox(width: 15),
                    SocialButton(icon: Icons.linked_camera_rounded, onTap: () {}), // Google
                    const SizedBox(width: 15),
                    SocialButton(icon: Icons.apple, onTap: () {}), // Apple
                  ],
                ),


const SizedBox(height: 50,),

                 // Terms and Privacy Policy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Terms of use',
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ),
                  const Text('|', style: TextStyle(color: Colors.grey)),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Privacy Policy',
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ),
                ],
              ),
           
    
                ],
              )
            ),
          ),
        
          
        
        ],)),
      )
      
      
     
    );
      
  }
}


// Widget for social buttons
class SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SocialButton({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.redAccent, size: 30),
      ),
    );
  }
}