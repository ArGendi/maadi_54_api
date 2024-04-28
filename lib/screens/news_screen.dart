// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List news = [];

  void getNews() async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
          "https://newsapi.org/v2/everything?q=apple&from=2024-04-14&to=2024-04-14&sortBy=popularity&apiKey=7cbef3e0859e47bea7efc555e5a5b35e");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        news = response.data["articles"];
        setState(() {});
      } else {
        print("Feeeeeh moshkla");
      }
    } catch (e) {
      print("Inside catch: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("News"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(news[index]["urlToImage"], width: 100, height: 100, fit: BoxFit.cover,),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  children: [
                    Text(news[index]["title"], style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(news[index]["description"])
                  ],
                ),
              )
            ],
          );
        },
        separatorBuilder: (context, index){
          return SizedBox(height: 20,);
        },
        itemCount: news.length,
      ),
    );
  }
}
