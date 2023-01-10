import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
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
            //Email Start
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
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
            //Email Stop
            SizedBox(
              height: 10,
            ),
            //Button Start
            MaterialButton(
              onPressed: () {},
              child: Text(
                'รีเซ็ตรหัสผ่าน',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            )

            //Button Stop
          ],
        ),
      ),
    );
  }
}
