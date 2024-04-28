// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maadi_54_api/screens/news_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    Dio dio = Dio(BaseOptions(
                      followRedirects: true,
                      receiveDataWhenStatusError: true,
                    ));
                    var response = await dio.post(
                        "https://project1.amit-learning.com/api/auth/login",
                        data: {
                          "email": emailController.text,
                          "password": passwordController.text,
                        });
                    if (response.statusCode == 200) {
                      if (response.data["status"] == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsScreen()));
                      } else {
                        throw ("");
                      }
                    } else {
                      throw ("");
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid email or password"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Text("Login"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async{
                  try{
                    Dio dio = Dio();
                    var response = await dio.get(
                      "https://project1.amit-learning.com/api/category",
                      options: Options(
                        headers: {
                          //"Authorization": "Bearer 1217|ORBXKdu8npFhR9N8eU73RszF1pwf1yQ7J7HZslBa",
                        }
                      )
                    );
                    if(response.statusCode == 200){
                      print(response.data);
                    }
                    else{
                      throw();
                    }
                  }
                  catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Text("Get Categories"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
