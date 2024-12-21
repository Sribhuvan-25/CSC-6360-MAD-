import 'package:text_messaging/utils/auth_service.dart';
import 'package:text_messaging/utils/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  void signUp() async {
    // if(passwordController.text != confirmPasswordController){
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Password do not match!")),
    //   );
    //   return;
    // }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
        emailController.text,
        passwordController.text,
        usernameController.text,
        firstnameController.text,
        lastnameController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //logo
          Text(
            "Chat",
            style: TextStyle(fontSize: 70),
          ),
          const SizedBox(
            height: 5,
          ),
          //welcome back message
          Text(
            "Enter your details",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          //email textfield

          MyTextField(
              controller: firstnameController,
              hintText: "First Name",
              obscureText: false),
          const SizedBox(
            height: 5,
          ),

          MyTextField(
              controller: lastnameController,
              hintText: "Last Name",
              obscureText: false),
          const SizedBox(
            height: 5,
          ),

          MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false),
          const SizedBox(
            height: 5,
          ),
          //password textfield
          MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true),
          const SizedBox(
            height: 10,
          ),
          //confirm password textfield
          //Sign IN button
          ElevatedButton(
            onPressed: signUp,
            child: Text("Register"),
            style: ButtonStyle(
              padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.fromLTRB(70, 15, 70, 15)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  "Sign In instead",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
