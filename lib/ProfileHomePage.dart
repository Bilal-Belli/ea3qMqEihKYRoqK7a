import 'package:flutter/material.dart';

class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card',style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _getProfileCard(context, Colors.white),
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: _getAvatar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getProfileCard(BuildContext context, Color textColor) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 60),
          Text(
            "Bilal Belli",
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _socialMediaRow(
            "bilal.belli@etu.umontpellier.fr",
            textColor,
          ),
          const SizedBox(height: 8),
          _socialMediaRow(
            "@bilal_belli_",
            textColor,
          ),
        ],
      ),
    );
  }

  Widget _getAvatar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.pinkAccent,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: Image.asset(
            'assets/images/user.jpg',
            fit: BoxFit.cover,
            width: 140,
            height: 140,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, size: 50, color: Colors.red);
            },
          ),
        ),
      ),
    );
  }

  Widget _socialMediaRow(String text, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}