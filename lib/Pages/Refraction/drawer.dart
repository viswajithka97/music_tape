import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.6, -0.10),
          colors: [
            Color.fromARGB(255, 172, 120, 225),
            Color(0xFFB59CDA),
            Color(0xFFC28ADC),
            Color(0xFFAA8BE5),
            Color(0xFFAD78E1),
            Color(0xFFAB76E0),
          ],
          radius: 1.5,
          focalRadius: 15.5,
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AppBar(
              title:const Text(
                'Music Tape',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.share, size: 35.h.w),
              title: const Text('Share'),
              onTap: () {
                Share.share('Hey Check out This App');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.verified,
                size: 35.h.w,
              ),
              title: const Text('Version'),
              subtitle:const Text('1.0.1'),
              onTap: () {
              
              },
            ),
            ListTile(
              leading:const Icon(Icons.verified_user_outlined, size: 35),
              title: const Text('Terms & Conditions'),
              subtitle:const Text('All the Information you need to know'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined, size: 35.h.w),
              title: const Text('Privacy Policy'),
              subtitle:const Text('Important for both of us'),
              onTap: () {
                
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info, size: 35.h.w),
              title: const Text('About'),
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationName: 'Music_Tape',
                    applicationVersion: '1.0.1',
                    children: [
                   const   Text(
                          'Music_ Tape is an Offline Music Player created by Viswajith K A'),
                    ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
