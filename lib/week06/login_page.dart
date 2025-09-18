import 'package:flutter/material.dart';

const Color bgColor = Color(0xFF202020);
const Color primaryColor = Color(0xFFFFBD73);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Image
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/baking.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // Sign In Section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SIGN IN / SIGN UP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(color: primaryColor, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),

                  // Email Row
                  Row(
                    children: [
                      const Icon(Icons.alternate_email, color: primaryColor),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Password Row
                  Row(
                    children: [
                      const Icon(Icons.lock_open, color: primaryColor),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // BOTTOM ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Fingerprint Button
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: bgColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white24),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.adb,
                                color: Colors.grey,
                                size: 28,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Message Button
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: bgColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white24),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.message,
                                color: Colors.grey,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Arrow Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: bgColor,
                          size: 29,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
