import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raidereats_sellers_app/global/global.dart';
import 'package:raidereats_sellers_app/mainScreens/itemsScreen.dart';
import '../model/menus.dart';


class InfoDesignWidget extends StatefulWidget {
 Menus? model;
 BuildContext? context;

 InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {


  deleteMenu(String menuID)
  {
    FirebaseFirestore.instance.collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Menu Deleted Successfully");

  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1.0,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                     widget.model!.menuTitle!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontFamily: "Bebas",
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: ()
                    {
                      deleteMenu(widget.model!.menuID!);
                    },
                  ),
                ],
              ),



                 //Text(
                //widget.model!.menuInfo!,
                // style: const TextStyle(
                //  color: Colors.black,
                //  fontSize: 12,
               //   fontFamily: "Signatra",
               // ),
              // ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
