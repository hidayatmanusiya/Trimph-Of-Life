import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget myGroup() {
  return Container(
    child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, i) {
          return null;
        }),
  );
}

Widget allGroup() {
  return Scaffold(
    body: Container(
      height: Get.height,
      width: Get.width,
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage("assets/james.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text("Group Title Here"),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Last Post")
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                  thickness: 2,
                ),
              ],
            );
          }),
    ),
  );
}
