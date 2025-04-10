import 'package:flutter/material.dart';

class Artists extends StatelessWidget {
  const Artists({super.key});

  void refresh(){
    // this method refresh the page
  }

  void downloadExcel(){
    // this method downloadExcel pdf
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: Container(
            color: Colors.blue[600],
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xffE6E6E6),
                          radius: 25,
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "Artists",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: refresh,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            shape: CircleBorder (),
                          ),
                          child: Icon(Icons.refresh_outlined, size: 27, color: Colors.black,),
                        ),
                        TextButton(
                          onPressed: downloadExcel,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Download Excel",
                            style: const TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5,),
              ]
            ),
          ),
        ),
    );
  }
}