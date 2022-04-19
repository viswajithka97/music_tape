 import 'package:flutter/material.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0,left: 10.0,right: 10.0),
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 227, 194, 233)),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5.0), //or 15.0
            child: Container(
              height: 70.0,
              width: 50.0,
              child: Image.asset(
                'asset/images/download.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text('KGF Chapter 2'),
          subtitle: Text('Unknown Artist'),
          trailing: Icon(Icons.favorite_outlined,color: Colors.red,),
        ),
      ),
    );
  }
}