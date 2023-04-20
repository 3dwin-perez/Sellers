import 'package:flutter/material.dart';
import 'package:raidereats_sellers_app/mainScreens/item_detail_screen.dart';
import 'package:raidereats_sellers_app/model/items.dart';



class ItemsDesignWidget extends StatefulWidget {

  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsDetailsScreeen(model: widget.model)));
      },
      splashColor: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 1,),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontFamily: "Bebas",
                ),
              ),
              const SizedBox(height: 2,),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 2,),

              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: "Bebas",
                ),
              ),
              const SizedBox(height: 2,),
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
