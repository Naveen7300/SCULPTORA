import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Signup App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.green[400],
              child: Text(
                "LOGO",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "NAME AND TAG LINE",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 40.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("EMAIL"),
                  SizedBox(height: 20.0),
                  _buildTextField("PASSWORD"),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            _buildButton("LOGIN", () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Call your login API here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            }),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text("DON'T HAVE AN ACCOUNT? SIGNUP"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onSaved: (value) {
          if (label == "EMAIL") {
            _email = value!;
          } else {
            _password = value!;
          }
        },
        obscureText: label == "PASSWORD",
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _phone = '';
  String _email = '';
  String _password = '';
  String _verifyPass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.green[400],
              child: Text(
                "LOGO",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "NAME AND TAG LINE",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 40.0),
            _buildTextField("FULL NAME"),
            SizedBox(height: 20.0),
            _buildTextField("PHONE NO."),
            SizedBox(height: 20.0),
            _buildTextField("EMAIL"),
            SizedBox(height: 20.0),
            _buildTextField("PASSWORD"),
            SizedBox(height: 20.0),
            _buildTextField("CONFIRM PASSWORD"),
            SizedBox(height: 40.0),
            _buildButton("SIGNUP", () {}),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("ALREADY HAVE AN ACCOUNT? LOGIN"),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTextField(String label) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onSaved: (value) {
          if (label == "FULL NAME") {
            _fullName = value!;
          } else if (label == "PHONE NO.") {
            _phone = value!;
          } else if (label == "EMAIL") {
            _email = value!;
          } else if (label == "PASSWORD") {
            _password = value!;
          } else {
            _verifyPass = value!;
          }
        },
        obscureText: label == "PASSWORD" || label == "VERIFY PASSWORD",
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.green,
              child: Center(child: Text('LOGO', style: TextStyle(color: Colors.black))),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NAME', style: TextStyle(color: Colors.black)),
                Text('TAG LINE', style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
        actions: [
          Icon(Icons.menu, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        color: Colors.blue[100], // Light blue background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(context, "LAUNDRY", (){
              print("Button Pressed");
            }),
            _buildButton(context, "TAILORING", (){
              print("Button Pressed");
            }),
            _buildButton(context, "SNEAKLEAN", (){
              print("Button Pressed");
            })
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: SizedBox(
        width: double.infinity, // Full width
        height: 100, // Fixed height for rectangular shape
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/laundry.png'), // Background image
                  fit: BoxFit.cover, // Make the image cover the entire button
                ),
                borderRadius: BorderRadius.circular(0), // No rounded corners
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Transparent button background
                shadowColor: Colors.transparent, // Remove button shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // No rounded corners
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color over the image
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0), // Shadow for better readability
                        blurRadius: 3.0,
                        color: Colors.black,
                      ),
                    ],
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