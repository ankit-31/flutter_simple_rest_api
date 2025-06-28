import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/GetModel.dart';
import 'package:http/http.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<GetModel>getmodel=[];



  Future<List<GetModel>> fetch()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'
    ),headers: {
      'User-Agent':"Mozilla/5.0", //as it think bot is requesting (throw 403) so we trick to treat as a browser
      'Accept' :'application/json'
    });
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      getmodel.clear();

      for(Map i in data){
        getmodel.add(GetModel.fromJson(i));



      }


    }

    return getmodel;}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: FutureBuilder(future: fetch(), builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());

        }
        else{
          var items=snapshot.data!;
          return ListView.builder(itemBuilder: (context,index){
            return Card(
              child: ListTile(
                title: Text(' Id is ${items[index].userId}'),
                subtitle: Text('Description is ${items[index].body}'),
                leading: Text('User Id is ${items[index].id}'),

              ),
            );
          },
            itemCount: items.length,

          );

        }

      }),


    );
  }
}
