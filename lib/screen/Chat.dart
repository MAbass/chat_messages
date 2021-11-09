import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  static String routeName = "/chat";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Application"),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Logout")
                    ],
                  ),
                ),
                value: "logout",
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "logout") {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            // print("Data: ${streamSnapshot.data.toString()}");
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chats/8WLV4wSNNgC8u4HuIX7e/messages")
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
