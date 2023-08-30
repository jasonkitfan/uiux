import 'package:flutter/material.dart';

class HDBanner extends StatelessWidget {
  const HDBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/banner.png"),
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      height: 300,
      child: Container(
        color: Colors.black.withOpacity(0.6),
        height: 300,
        padding: const EdgeInsets.all(50),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Higher Diploma",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              "Expand Your Knowledge and Skills with a Higher Diploma!",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
