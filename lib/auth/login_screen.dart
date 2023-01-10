import 'package:MMPOS/auth/forget_screen.dart';
import 'package:MMPOS/auth/register_screen.dart';
import 'package:MMPOS/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.white,
            Color.fromARGB(255, 224, 108, 99),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo Start
            Center(
              child: Container(
                width: 120,
                height: 120,
                child: Image.asset(
                  'assets/images/mmpos_outline_white.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            //Logo Stop
            SizedBox(height: 10),
            //Login Start
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'อีเมล',
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            //Login Stop
            SizedBox(height: 10),
            //Password Start
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'รหัสผ่าน',
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            //Password Stop
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ForgotScreen()));
                        print('forgotpassword');
                      },
                      child: Text('ลืมรหัสผ่าน?')),
                ],
              ),
            ),
            SizedBox(height: 10),
            //Button Start
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () async {
                    try {
                      if (email.text.length > 0 && password.text.length > 0) {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.text.toString().trim(),
                            password: password.text.toString().trim());
                      }
                    } catch (e) {
                      print(e);
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ));
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => NewMain()));
                    // print('complete');
                  },
                  child: Center(
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Button Stop
            SizedBox(height: 10),
            //Text Register Start
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ยังไม่มีสมาชิก?'),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                      print('complete');
                    },
                    child: Text(
                      'สมัครสมาชิก',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ))
              ],
            )
            //Text Register Stop
          ],
        ),
      ),
    );
  }
}
