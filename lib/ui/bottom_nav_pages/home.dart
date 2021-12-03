import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(child: Container(
       child: Column(
         children: [
            Expanded(child: TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
              fillColor: Colors.white,

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
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



            )),
           Container(
             height: 60,
             width: 60,
             child: Center(
               child: Icon(Icons.search,color: Colors.white,),
             ) ,

           )
         ],
       ),
     ),),
    );
  }
}
