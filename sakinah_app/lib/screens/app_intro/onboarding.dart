// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:sakinah_app/helper/navigation.dart';
import 'package:sakinah_app/screens/signin.dart';
import 'package:sakinah_app/widget/onboardcard.dart';
import 'package:sakinah_app/widget/pageindicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "images/mus4.png",
      "title": "Premium",
      "description":
          "Sign up today and enjoy the first month of premium benefits on us."
    },

    {
      "image": "images/mus3.png",
      "title": "Premium",
      "description":
          "Sign up today and enjoy the first month of premium benefits on us."
    },

    {
      "image": "images/mus2.png",
      "title": "Premium",
      "description":
          "Sign up today and enjoy the first month of premium benefits on us."
    },
    // Add more pages here if needed
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      changeScreenReplacement(context, SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingCard(
                  image: onboardingData[index]["image"]!,
                  title: onboardingData[index]["title"]!,
                  description: onboardingData[index]["description"]!,
                );
              },
            ),
          ),
          PageIndicator(
              currentIndex: _currentPage, totalPages: onboardingData.length),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Create an account",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    changeScreenReplacement(context, SignInScreen());
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
