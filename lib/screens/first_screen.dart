import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/datamodels/foresties.dart';
import 'package:tinyforests/screens/forest_detail_screen.dart';
import 'package:tinyforests/widgets/builderitems.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            "Tiny Forests",
            style: TextStyle(fontSize: 20.sp, color: Colors.black),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            height: 40.h,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 3.h,
                  mainAxisSpacing: 3.h,
                  childAspectRatio: 1.6,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: tForest.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new screen when an image is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            forestName: tForest[index].forestName,
                            image: tForest[index].image,
                            yearPlanted: tForest[index].yearPlanted,
                            totalTrees: tForest[index].totalTrees,
                          ),
                        ),
                      );
                    },
                    child: GridViewContainer(
                      itemImage: tForest[index].image,
                      itemText: tForest[index].forestName,
                      alignmentOfMain: MainAxisAlignment.start,
                    ),
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}
