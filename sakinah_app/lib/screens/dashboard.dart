// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TCardController _cardController = TCardController();

  final List<Map<String, String>> profiles = [
    {
      "name": "Jessica Parker, 23",
      "profession": "Professional model",
      "distance": "1 km",
      "image": "images/mus4.png", // Add your image in assets
    },
    // Add more profiles if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50),
          _buildTopBar(),
          Expanded(
            child: TCard(
              controller: _cardController,
              size: Size(MediaQuery.of(context).size.width * 0.9, 550),
              cards: profiles.map((profile) => _buildProfileCard(profile)).toList(),
            ),
          ),
          _buildBottomActions(),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {},
          ),
          Column(
            children: [
              Text("Discover", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text("Chicago, IL", style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          IconButton(
            icon: Icon(Icons.tune, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(Map<String, String> profile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.asset(profile["image"]!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.black),
                  SizedBox(width: 5),
                  Text(profile["distance"]!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile["name"]!, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(profile["profession"]!, style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(Icons.close, Colors.orange),
          SizedBox(width: 20),
          _buildActionButton(Icons.favorite, Colors.red, isBig: true),
          SizedBox(width: 20),
          _buildActionButton(Icons.star, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, {bool isBig = false}) {
    return Container(
      width: isBig ? 80 : 60,
      height: isBig ? 80 : 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.2),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: isBig ? 36 : 30),
        onPressed: () {},
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.style, size: 28, color: Colors.grey), onPressed: () {}),
          IconButton(icon: Icon(Icons.favorite, size: 28, color: Colors.red), onPressed: () {}),
          IconButton(icon: Icon(Icons.chat_bubble_outline, size: 28, color: Colors.grey), onPressed: () {}),
          IconButton(icon: Icon(Icons.person_outline, size: 28, color: Colors.grey), onPressed: () {}),
        ],
      ),
    );
  }
}