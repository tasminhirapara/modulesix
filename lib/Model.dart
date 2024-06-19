import 'package:flutter/material.dart';

class Model extends StatelessWidget
{
  late List list;

  Model({required this.list});

  @override
  Widget build(BuildContext context)
  {

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10,bottom: 10),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index)
      {
        return Container(
          padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          child: Align(
            alignment: (list[index]['type'] == "receiver"?Alignment.topLeft:Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (list[index]['type']  == "receiver"?Colors.grey.shade200:Colors.indigoAccent),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(list[index]['name'],),
                  Text(list[index]['message'], style: TextStyle(fontSize: 15,color:(list[index]['type']  == "receiver"?Colors.indigoAccent:Colors.white) ),),
                ],
              ),
            ),
          ),
        );
      },
      itemCount:list.length,);
  }
}


