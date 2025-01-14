import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_hndit_individual/const/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import"package:flutter/material.dart";

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) => print("Added to cart"));
  }

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) => print("Added to favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.deep_orange,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items").where("name",isEqualTo: widget._product['product-name']).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    onPressed: () => snapshot.data.docs.length==0?addToFavourite():print("Already Added"),
                    icon: snapshot.data.docs.length==0? const Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ):const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },

          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                    aspectRatio: 2,
                    child: Container(
                        color: Colors.transparent,
                        child: Image.network(
                          widget._product["product-img"],
                        ))),
                // AspectRatio(
                //   aspectRatio: 3.5,
                //   child: CarouselSlider(
                //       items: widget._product['product-img']
                //           .map<Widget>((item) => Padding(
                //         padding: const EdgeInsets.only(left: 3, right: 3),
                //         child: Container(
                //           decoration: BoxDecoration(
                //               image: DecorationImage(
                //                   image: NetworkImage(item),
                //                   fit: BoxFit.fitWidth)),
                //         ),
                //       ))
                //           .toList(),
                //       options: CarouselOptions(
                //           autoPlay: false,
                //           enlargeCenterPage: true,
                //           viewportFraction: 0.8,
                //           enlargeStrategy: CenterPageEnlargeStrategy.height,
                //           onPageChanged: (val, carouselPageChangedReason) {
                //             setState(() {});
                //           })),
                // ),
                Text(
                  widget._product['product-name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(widget._product['product-description']),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "\Rs ${widget._product['product-price'].toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30, color: Colors.red),
                ),
                Divider(),
                SizedBox(
                  width: 600,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => addToCart(),
                    child: const Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.deep_orange,
                      elevation: 3,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
