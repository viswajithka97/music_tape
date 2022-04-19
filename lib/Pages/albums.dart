import 'package:flutter/material.dart';
import 'package:music_tape/Pages/Refraction/drawer.dart';

class Albums extends StatelessWidget {
  const Albums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 214, 165, 236),
      drawer: drawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Albums',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 35),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 35,
              ))
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 10.0,
                childAspectRatio:8/10
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 100, 159, 207)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0), //or 15.0
                        child: Container(
                          decoration: BoxDecoration(),
                          height: 230.0,
                          width: double.infinity,
                          child: Image.asset(
                            'asset/images/download.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'KGF Chapter 2',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      '123musiq.com',
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
