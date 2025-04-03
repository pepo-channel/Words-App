import 'package:flutter/material.dart';
import 'package:word_app/core/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: colorsdata.BaisicColor,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colorsdata.WhiteColor,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Words',
                  style: TextStyle(
                    color: colorsdata.WhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // 
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorsdata.ButtonColor,
                    ),
                    child: Center(
                      child: Icon(Icons.sort_by_alpha, color: colorsdata.WhiteColor, size: 30,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}