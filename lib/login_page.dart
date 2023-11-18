import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Spacer(),
            Text('Welcome to Poetry Palette!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(
              height: 16,
            ),
            Text('Login to continue', style: TextStyle(
              color: Colors.white,
            ),),
            Spacer(),
            TextField(
              decoration: InputDecoration(hintText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.5),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.5),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed:(){
                print('Forgot is clicked');
              },
                  style: TextButton.styleFrom(foregroundColor: Colors.white,),
                  child: Text('Forgot password?')),
            ),
            SizedBox(height: 32,),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(onPressed: () {
                Navigator.of(context).pushReplacementNamed('/main');
              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.black,),
                  child: Text('Log in')),
            ),
            Spacer(),
            Text('Or sign in with',
              style: TextStyle
                (color: Colors.white,
              ),
            ),
            SizedBox(height: 16,),
            SizedBox(
              height: 48,
              child: ElevatedButton(onPressed: () {
                print('Google is clicked');
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50),)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset
                    ('assets/images/google.png',
                    width: 22,
                    height: 22,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Login with Google'),
                ],
              ),
              ),
            ),
            SizedBox(height: 16,),
            SizedBox(
              height: 48,
              child: ElevatedButton(onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50),)
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/facebook.png',
                    width: 22,
                    height: 22,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Login with Facebook'),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Row(
                children: [
                  Text("Don't have account? ",style: TextStyle(color: Colors.white,),),
                  TextButton(onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                      ),
                      child: Text('Sign up', style:
                      TextStyle(decoration: TextDecoration.underline,),)),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
