import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer {
  Widget category() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          6,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ttb,
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 10,
                      width: 50,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget productsShimmer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          direction: ShimmerDirection.ttb,
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey,
          child: SizedBox(
            height: 300,
            width: 400,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: 300,
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 100,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 40,
                            color: Colors.grey,
                          ),
                          Container(
                            height: 10,
                            width: 40,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 20,
                                color: Colors.grey,
                              ),
                              Container(
                                height: 10,
                                width: 20,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 20,
                                color: Colors.grey,
                              ),
                              Container(
                                height: 10,
                                width: 20,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
