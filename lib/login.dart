import 'package:flutter/material.dart';
import 'package:pos/constants.dart';
import 'package:pos/mainscreens/counter.dart';
import 'package:pos/mainscreens/home.dart';
import 'package:pos/register.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: secondcolor
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Please login to your account.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
               
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Navigate to forgot password screen
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child:ElevatedButton(
  onPressed: () {
    // Handle login logic here
     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Counter(items: [])),
                  ); // 
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 15),
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Adjust the radius for rounded corners
    ),
  ),
  child: Text(
    'Login',
    style: TextStyle(fontSize: 18),
  ),
),

            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  ); // Navigate to Register Screen
                },
                child: Text(
                  "Don't have an account? Register",
                  style: TextStyle(
                    color: secondcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
