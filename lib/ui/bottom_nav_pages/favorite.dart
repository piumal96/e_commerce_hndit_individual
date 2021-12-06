import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots( ), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Somthing Is Wrong"),);
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_,index){
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                return Card(
                  elevation: 10,
                  child: ListTile(
                    leading: Text(_documentSnapshot['name']),
                    title: Text("\Rs ${_documentSnapshot['price']}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                    trailing: GestureDetector(
                      child: const CircleAvatar(
                        child: Icon(Icons.remove_circle),
                      ),
                      onTap: (){
                        FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(_documentSnapshot.id).delete();
                      },
                    ),
                  ),
                );
              }
          );
        },
        ),
      ),
    );
  }
}
