import 'package:MMPOS/auth/login_screen.dart';
import 'package:MMPOS/page_backend/service_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordC = TextEditingController();
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
                child: Image.asset('assets/images/mmpos_outline_white.png'),
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
                obscureText: true,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'รหัสผ่าน',
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            //Password Stop
            SizedBox(height: 10),
            //Password Start
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: passwordC,
                obscureText: true,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'ยินยันรหัสผ่าน',
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            //Password Stop
            SizedBox(height: 10),
            //Button Start
            GestureDetector(
              onTap: () async => {
                if (email.text.length > 0 &&
                    password.text.length > 0 &&
                    password.text == passwordC.text)
                  {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text.trim(),
                        password: password.text.trim()),
                    await UserStore.insert(email: email.text.trim())
                  }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'สมัครสมาชิก',
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

            //Text Register Start
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('มีบัญชีอยู่เเล้ว?'),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                      print('complete');
                    },
                    child: Text(
                      'เข้าสู่ระบบ',
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
