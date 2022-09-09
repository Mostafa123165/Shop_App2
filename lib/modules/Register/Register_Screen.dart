import 'package:flutter/material.dart';
import 'package:shopapp2/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text(
              'Register',
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              'Register Now to browser our hot offers ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600
              ),
            ),
         //   defaultTextFormFeild(controller: controller, submitted: submitted, validator: validator, lapel: lapel)
          ],
        ),
      ),
    );
  }
}
