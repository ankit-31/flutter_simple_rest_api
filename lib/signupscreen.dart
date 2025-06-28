import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restapi1/getrequest.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
//we can first test with post man and then with below code

void login(String email,String password,BuildContext context)async{
  Response response = await post(
    Uri.parse('https://reqres.in/api/register'),//same for login
    body: {
      'email':email,
      'password':password,
    },
    headers: {
      'x-api-key':'reqres-free-v1'

    }

  );
  if(response.statusCode==200){
    var data=jsonDecode(response.body.toString());//password pistol
  print('Account created Sucessfully');//email eve.holt@reqres.in
    print(data['token']);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));




  }
  else{
    print('Failed to Register');


  }
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController ?emailController =TextEditingController();
  TextEditingController ?passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),

            ),
            SizedBox(
              height: 30,
            ),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter password'
                    ,
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(10),
                )
              ),

            ),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(



                style: ButtonStyle(

                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                ),
                  onPressed: (){

                  login(emailController!.text.toString(),passwordController!.text.toString(),context);



              }, child: Text('Signup',style: TextStyle(fontSize: 18,color: Colors.black),)),
            )
          ],
        ),
      ),

    );
  }
}


