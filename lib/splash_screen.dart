import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'snowman_game.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ahmad Snowman Game',
              style: TextStyle(
                fontSize: 100,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool loggedIn = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
                if (loggedIn == true) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SnowmanGame()),
                  );
                }
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool registered = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignupPage()),
                );
                if (registered == true) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                }
              },
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const SnowmanGame()),
                );
              },
              child: Text(
                'Continue as Guest',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
