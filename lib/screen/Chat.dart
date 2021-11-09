import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            // print("Data: ${streamSnapshot.data.toString()}");
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chats/LYh94IQdU4rPhZwx6kiU/messages")
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    final Map<String, dynamic> dataDocuments =
                        data.docs[0].data() as Map<String, dynamic>;
                    // print("Size: ${data.size}");
                    // print("Data: ${dataDocuments}");
                    // print("Reference: ${data.docs[0].reference}");
                    return ListView.builder(
                        itemCount: dataDocuments.length,
                        itemBuilder: (ctx, index) {
                          return Text(
                            "For key:${dataDocuments.keys.elementAt(index)}, we have: ${dataDocuments.values.elementAt(index)}",
                            style: TextStyle(fontSize: 18),
                          );
                        });
                    ;
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return CircularProgressIndicator();
                  }
                });
          }
        },
      ),
    );
  }
}
