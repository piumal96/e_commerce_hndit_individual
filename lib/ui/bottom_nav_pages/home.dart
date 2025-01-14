import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_hndit_individual/const/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../product_details_screen.dart';
import '../search_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  final TextEditingController _searchController= TextEditingController();

  fetchCarouselImages() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }
  fetchproducts() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add(
            {
              "product-name": qn.docs[i]["product-name"],
              "product-description": qn.docs[i]["product-description"],
              "product-img": qn.docs[i]["product-img"],
              "product-price": qn.docs[i]["product-price"],
            }
        );
        //   print(qn.docs[i]["product-price"]);
      }
    });

    return qn.docs;
  }
  @override
  void initState() {
    fetchCarouselImages();
    super.initState();
    fetchproducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20  ),
                child: Row(
                  children: [
                    Expanded(child:
                    Padding(

                      padding: const EdgeInsets.all(8.0),

                      child: TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,

                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Colors.blue
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.grey
                            ),
                          ),
                          hintText: "Search Product here",
                          hintStyle: TextStyle(fontSize: 15),


                        ),
                        onTap: ()=>Navigator.push(context,CupertinoPageRoute(builder: (_)=>SearchScreen())  ),



                      ),
                    )),
                    // GestureDetector(
                    //   child: Container(
                    //     height: 60,
                    //     width: 60,
                    //     color: AppColors.deep_orange,
                    //
                    //     child: const Center(
                    //       child: Icon(Icons.search,color: Colors.white,),
                    //     ) ,
                    //
                    //   ),
                    //   onTap: (){},
                    // )

                  ],

                ),
              ),
              SizedBox(height: 10 ,),
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                    items: _carouselImages
                        .map((item) => Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(item),
                                fit: BoxFit.fitWidth)),
                      ),
                    ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, carouselPageChangedReason) {
                          setState(() {

                          });
                        })),
              ),
              SizedBox(height: 10,),
              DotsIndicator( dotsCount:
              _carouselImages.length == 0 ? 1 : _carouselImages.length,
                position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: AppColors.deep_orange,
                  color: AppColors.deep_orange.withOpacity(0.5),
                  spacing: EdgeInsets.all(2),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetails(_products[index]))),
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(
                                  aspectRatio: 2,
                                  child: Container(
                                      color: Colors.transparent,
                                      child: Image.network(
                                        _products[index]["product-img"],
                                      ))),
                              Text("${_products[index]["product-name"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54),

                              ),
                              Text(
                                  "\Rs ${_products[index]["product-price"].toString()}",
                                   style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red),
                              ),

                            ],
                          ),
                        ),
                      );
                    }),
              ),


            ],
          ),
        ),),
    );
  }
}