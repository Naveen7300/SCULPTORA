// ~Naveen Jain
// codex.naveenj@gmail.com
// https://github.com/Naveen7300/SCULPTORA_V2
// ~Vraj Patel
// vraj9patel.06@gmail.com
// https://github.com/Vraj6355

import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCULPTORA',
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class NavigationService {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static String _currentRoute = '/';

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static void setCurrentRoute(String route) {
    _currentRoute = route;
  }

  static String getCurrentRoute() {
    return _currentRoute;
  }
}

// Create a separate function for the AppBar
PreferredSizeWidget _customAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.lightBlue[300],
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        if (NavigationService.getCurrentRoute() == '/HomePage') {
          // If on HomePage, navigate to LoginPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else if (NavigationService.getCurrentRoute() != '/HomePage'){
          // If on any other page, navigate to HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
    ),
    title: Row(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: EdgeInsets.only(right: 10),
          child: Center(
              child: Image(
                image: AssetImage('assets/Sculptora_Logo.png'),
              )
          ),
        ),
        //SizedBox(width: 5),
        Padding(
          padding: EdgeInsets.only(top: 15), // Add top & right padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  'SCULPTORA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32
                  )
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      PopupMenuButton(
        icon: Icon(Icons.menu),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text('Profile'),
            value: 'profile',
          ),
          PopupMenuItem(
            child: Text('Orders'),
            value: 'orders',
          ),
          PopupMenuItem(
            child: Text('About Us'),
            value: 'about',
          ),
          PopupMenuItem(
            child: Text('Contact'),
            value: 'contact',
          ),
        ],
        onSelected: (value) {
          if (value == 'profile') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else if (value == 'orders') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrdersPage()),
            );
          } else if (value == 'about') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsPage()),
            );
          } else if (value == 'contact') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactPage()),
            );
          }
        },
      ),
    ],
  );
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
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/LoginPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Image(
                      image: AssetImage('assets/Sculptora_Logo.png'),
                    )),
                //SizedBox(height: 20.0),
                Text(
                  "SCULPTORA",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "EXQUISITE CARE FOR EVERY PIECE YOU WEAR",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 85),
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
                // Removed TextButton from here
              ],
            ),
          ),
          Positioned( // Position the TextButton at the bottom
            bottom: 20.0,
            left: 0,
            right: 0,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text("DON'T HAVE AN ACCOUNT? SIGNUP"),
            ),
          ),
        ],
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
        width: 200.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // No rounded corners
            ),
            padding: EdgeInsets.zero, // Remove default padding
          ),
          child: Center(
            child: Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color over the image
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    // Shadow for better readability
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        )
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
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/SignUpPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Image(
                      image: AssetImage('assets/Sculptora_Logo.png'),
                      height: 200,
                      width: 200,
                    )
                ),
                //SizedBox(height: 20.0),
                Text(
                  "SCULPTORA",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "EXQUISITE CARE FOR EVERY PIECE YOU WEAR",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
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
                SizedBox(height: 80)
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("ALREADY HAVE AN ACCOUNT? LOGIN"),
              ),
            ),
          ),
        ],
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
        width: 200.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // No rounded corners
            ),
            padding: EdgeInsets.zero, // Remove default padding
          ),
          child: Center(
            child: Text(
              "SIGNUP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color over the image
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    // Shadow for better readability
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/HomePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(context),
      body: Container(
        color: Colors.lightBlue[100],
        child: Center( // Center content vertically
          child: ListView( // Use ListView for scrollable content
            shrinkWrap: true, // Shrink ListView to content size
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            children: [
              _buildLaundryButton(context, "LAUNDRY", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LaundryPage()));
              }),
              _buildTailoringButton(context, "TAILORING", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TailoringPage()));
                print("Button Pressed 2");
              }),
              _buildSneakLeanButton(context, "SNEAKLEAN", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SneakleanPage()));
                print("Button Pressed 3");
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLaundryButton(BuildContext context, String buttonText, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0), // Add bottom padding between buttons
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjusted blur
          child: Container(
            height: 230,
            decoration: BoxDecoration(
              image: DecorationImage( // Use DecorationImage for background
                image: AssetImage('assets/laundry.png'),
                fit: BoxFit.cover, // Cover the entire container
                colorFilter: ColorFilter.mode(// Apply color filter to image
                  Colors.black.withOpacity(0.55), // Adjust opacity as needed
                  BlendMode.dstATop,
                ),
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all( // Add border
                color: Colors.black, // Border color
                width: 5, // Border thickness
              ),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: onPressed,
              child: Center( // Center the text
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black, // Text color for better contrast
                    fontSize: 65,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTailoringButton(BuildContext context, String buttonText, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0), // Add bottom padding between buttons
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjusted blur
          child: Container(
            height: 230,
            decoration: BoxDecoration(
              image: DecorationImage( // Use DecorationImage for background
                image: AssetImage('assets/Tailoring.png'),
                fit: BoxFit.cover, // Cover the entire container
                colorFilter: ColorFilter.mode(// Apply color filter to image
                  Colors.black.withOpacity(0.5), // Adjust opacity as needed
                  BlendMode.dstATop,
                ),
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all( // Add border
                color: Colors.black, // Border color
                width: 5, // Border thickness
              ),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: onPressed,
              child: Center( // Center the text
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black, // Text color for better contrast
                    fontSize: 65,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSneakLeanButton(BuildContext context, String buttonText, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0), // Add bottom padding between buttons
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjusted blur
          child: Container(
            height: 230,
            decoration: BoxDecoration(
              image: DecorationImage( // Use DecorationImage for background
                image: AssetImage('assets/Sneaklean.png'),
                fit: BoxFit.cover, // Cover the entire container
                colorFilter: ColorFilter.mode(// Apply color filter to image
                  Colors.black.withOpacity(0.55), // Adjust opacity as needed
                  BlendMode.dstATop,
                ),
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all( // Add border
                color: Colors.black, // Border color
                width: 5, // Border thickness
              ),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: onPressed,
              child: Center( // Center the text
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black, // Text color for better contrast
                    fontSize: 65,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/ProfilePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: _customAppBar(context),
      body: Stack(
          children: [
            Positioned(
                top: 20.0,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: Text(
                    "PROFILE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
            ),
            Positioned(
                top: 100.0,
                left: 10.0,
                right: 10.0,
                child: Center(
                    child: Text(
                      '''Welcome to your Sculptora profile! This is your personal hub where you can manage your account and customize your preferences. Whether you're using our laundry, tailoring, or sneaker cleaning services, everything is streamlined to offer you a hassle-free experience.
\nIn your profile, you can:
\n➤ Update your personal information
➤ Set and manage your delivery addresses
➤ Save your preferred payment methods
➤ Adjust your notification settings and preferences
\nWith Sculptora, you’re always in control of your experience. Easily manage your information and enjoy quick access to all of our services.''',
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    )
                )
            )
          ]
      ),
    );
  }
}

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/OrdersPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: _customAppBar(context),
      body: Stack(
          children: [
            Positioned(
                top: 20.0,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: Text(
                    "ORDERS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
            ),
            Positioned(
                top: 100.0,
                left: 10.0,
                right: 10.0,
                child: Center(
                    child: Text(
                      '''Keep track of all your laundry, tailoring, and sneaker cleaning services in one place with our easy-to-use Orders section. Here, you can monitor the status of your ongoing services and review your service history.
\nIn the Orders section, you can:
\n➤ View the status of current services (pending, in progress, or 
     completed)
➤ Review past orders and payment details
➤ Reschedule or cancel orders if needed
\nStay updated and in control with real-time tracking for all your services. At Sculptora, we make sure everything is organized and transparent for a seamless experience.''',
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    )
                )
            )
          ]
      ),
    );
  }
}

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/AboutUsPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: _customAppBar(context),
      body: Stack(
        children: [
          Positioned(
            top: 20.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Text(
                "ABOUT US",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                ),
              ),
            )
          ),
          Positioned(
            top: 100.0,
              left: 10.0,
              right: 10.0,
              child: Center(
                child: Text(
                    '''Welcome to Sculptora, your one-stop solution for laundry, tailoring, and sneaker cleaning services at unbeatable prices! We understand the importance of convenience in your busy life, which is why we’ve brought together essential services under one roof, making it easier than ever to look and feel your best without breaking the bank.
\nOur app is designed to offer high-quality services at lower rates than market values, ensuring that you get value for money without compromising on quality. Whether you need fresh, clean clothes, perfectly tailored outfits, or sneakers that look brand new, we've got you covered.
\nExperience hassle-free services with Sculptora - because we believe you deserve more for less.''',
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                )
              )
          )
        ]
      ),
    );
  }
}

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/ContactPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: _customAppBar(context),
      body: Stack(
          children: [
            Positioned(
                top: 20.0,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: Text(
                    "CONTACT PAGE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
            ),
            Positioned(
                top: 100.0,
                left: 10.0,
                right: 10.0,
                child: Center(
                    child: Text(
                      '''We’re here to help! If you have any questions, feedback, or need assistance with our services, feel free to reach out. At Sculptora, customer satisfaction is our top priority, and we’re always ready to assist you.
\nYou can contact us through:
\nEmail: services@sculptora.com
Phone: 6355906727 / 7300310248
Live Chat: Available in-app for instant support
\nOur team is available 24X7 and will respond promptly to ensure you have the best experience with our laundry, tailoring, and sneaker cleaning services.''',
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    )
                )
            )
          ]
      ),
    );
  }
}

class LaundryPage extends StatefulWidget {
  @override
  _LaundryPageState createState() => _LaundryPageState();
}

class _LaundryPageState extends State<LaundryPage> {
  @override
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/LaundryPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: _customAppBar(context),
      body: Stack(
          children: [
            Positioned(
                top: 20.0,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: Text(
                    "LAUNDRY",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
            ),
            Positioned(
                top: 100.0,
                left: 10.0,
                right: 10.0,
                child: Center(
                    child: Text(
                      '''Need fresh, clean clothes without the hassle? Sculptora offers reliable laundry services at unbeatable prices. We take the stress out of laundry day by providing high-quality cleaning with fast pickups and deliveries—right at your doorstep.
\nOur laundry service includes:
\n➤ Wash, dry, and fold for everyday clothes
➤ Special care for delicate fabrics like silk, wool, and more
➤ Stain removal for tough, hard-to-clean spots
➤ Fast turnaround times to suit your schedule
\nSimply schedule a pickup, and we’ll handle the rest. With Sculptora, you get more than just clean clothes—you get convenience and peace of mind, all at a fraction of the cost of other services.''',
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    )
                )
            )
          ]
      ),
    );
  }
}

class TailoringPage extends StatefulWidget {
  @override
  _TailoringPageState createState() => _TailoringPageState();
}

class _TailoringPageState extends State<TailoringPage> {
  @override
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/TailoringPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: _customAppBar(context),
      body: Stack(
          children: [
            Positioned(
                top: 20.0,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: Text(
                    "TAILORING",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
            ),
            Positioned(
                top: 100.0,
                left: 10.0,
                right: 10.0,
                child: Center(
                    child: Text(
                      '''Need alterations or custom tailoring? Sculptora offers expert tailoring services designed to fit your needs and lifestyle. Whether it’s minor adjustments or full alterations, we ensure your clothes fit perfectly—all with the ease of scheduling from your phone.
\nOur tailoring services include:
\n➤ Alterations for dresses, suits, shirts, and more
➤ Hemming, repairs, and adjustments for a flawless fit
➤ Custom tailoring for that personalized touch
➤ Quick turnaround times to match your schedule
\nWith Sculptora, getting perfectly fitted clothes is easier than ever. Simply schedule a pickup, and our expert tailors will handle the rest. Enjoy tailor-made convenience, all at competitive prices.''',
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    )
                )
            )
          ]
      ),
    );
  }
}

class SneakleanPage extends StatefulWidget {
  @override
  _SneakleanPageState createState() => _SneakleanPageState();
}

class _SneakleanPageState extends State<SneakleanPage> {
  @override
  void initState() {
    super.initState();
    NavigationService.setCurrentRoute('/SneakleanPage');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: _customAppBar(context),
      body: Stack(
          children: [
            Positioned(
                top: 20.0,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: Text(
                    "SNEAKLEAN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
            ),
            Positioned(
                top: 100.0,
                left: 10.0,
                right: 10.0,
                child: Center(
                    child: Text(
                      '''Bring your favorite sneakers back to life with Sculptora professional sneaker cleaning service! We specialize in cleaning and restoring all types of sneakers, ensuring they look as good as new without the hassle of DIY cleaning.
\nOur sneakers cleaning services include:
\n➤ Deep cleaning for all types of sneakers (leather, suede,
     canvas, etc.)
➤ Stain and dirt removal to restore original color and texture
➤ Sole and upper cleaning for a complete refresh
➤ Careful handling to ensure your sneakers are cleaned without
     damage
\nWhether it’s your everyday kicks or limited-edition pairs, our sneaker cleaning experts will handle them with care. Schedule a pickup, and we’ll make sure your sneakers are returned looking fresh and spotless—all at competitive rates.''',
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    )
                )
            )
          ]
      ),
    );
  }
}