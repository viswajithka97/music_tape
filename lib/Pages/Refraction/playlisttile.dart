import 'package:flutter/material.dart';

class PlaylistTile extends StatelessWidget {
  final leadingicon;
  final iconcolor;
  final iconsize;
  final titletext;
  final subtitle;
  final trailingicon;

  PlaylistTile(
      {
        required this.leadingicon,
      required this.iconcolor,
      required this.iconsize,
      required this.titletext,
      required this.subtitle,
       this.trailingicon,
       });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingicon,
        color: iconcolor,
        size: iconsize,
      ),
      title: Text(titletext),
      subtitle: Text(subtitle),
      trailing: PopupMenuButton(
        icon: Icon(trailingicon), //don't specify icon if you want 3 dot menu
        // color: Colors.blue,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 0,
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.black),
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        onSelected: (item) => {print(item)},
      ),
    );
  }
}
