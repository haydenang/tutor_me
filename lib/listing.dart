import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Listing extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Listings"),),
      body: StreamBuilder<QuerySnapshot>(
      stream: widget._firestore.collection('listing').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          return Text('Loading...');
        }
        return ListView.builder(
          itemCount: snapshot.data?.docs.length, //QuerySnapshot.size,
          itemBuilder: (context, index) {
          String itemTitle = snapshot.data!.docs[index]['name'];
          return CardItem(itemTitle: itemTitle,);
        });
      },
    ),
    );
  }
}

class CardItem extends StatefulWidget {
  String itemTitle;
  CardItem({required this.itemTitle});
  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.itemTitle),
      ),
    );
  }
}