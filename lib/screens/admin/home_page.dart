import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(tabs: [
            Text("Banners"),
            Text("Banners"),
            Text("Banners"),
            Text("Banners"),
          ]),
        ),
        body: const TabBarView(children: [
          BannerBody(),
          Center(child: Text("Banners page")),
          Center(child: Text("Banners page")),
          Center(child: Text("Banners page")),
        ]),
      ),
    );
  }
}

class BannerBody extends StatelessWidget {
  const BannerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [
              Text("banner_image"),
              SizedBox(
                width: 10,
              ),
              Text(":"),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
       
            ],
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Add"))
        ],
      ),
    );
  }
}
