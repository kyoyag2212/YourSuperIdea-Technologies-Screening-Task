import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ShopInfo extends StatefulWidget {
  @override
  _ShopInfoState createState() => _ShopInfoState();
  final String shop_name;
  final int current_stock_value;
  final String imgUrl;
  ShopInfo(this.shop_name,this.current_stock_value,this.imgUrl ,{Key key}): super(key: key);


}

class _ShopInfoState extends State<ShopInfo> {




void initState(){

  super.initState();
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('YourSuperIdea Technologies'),
        elevation: 0.0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)
            )
        ),
      ),
      body:Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 40, 0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(backgroundImage: NetworkImage(widget.imgUrl),
                  backgroundColor: Colors.white70,

                  radius:120.0
              ),
            ),
            Text('Shop Name',
                style:TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height:10.0),
            Text(widget.shop_name,
              style: TextStyle(
                color:Colors.white70,
                letterSpacing: 2.0,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Divider(height:60.0,color: Colors.black87),
            Text('Total Stock Value',
                style:TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height:10.0),
            Text(widget.current_stock_value.toString(),
              style: TextStyle(
                color:Colors.white70,
                letterSpacing: 2.0,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),


          ],

        ),
      ),





    );
  }
}