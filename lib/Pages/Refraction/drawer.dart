import 'package:flutter/material.dart';

class drawer extends StatelessWidget {
  const drawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            
            AppBar(
              title: Text('Music Tape',style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.transparent,
              elevation: 0,
          
             automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.verified_user_outlined),
              title: const Text('Terms & Conditions'),
              onTap: () {
                Navigator.pop(context);
              },
           ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
  }
}