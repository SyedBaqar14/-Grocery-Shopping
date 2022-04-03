import 'package:flutter/material.dart';
import 'package:grocery_shopping/utils/config/asset_config.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/components/asset_provider.dart';
import 'package:shimmer/shimmer.dart';

class OrdersShimmer {
  Widget trackOrderShimmer(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey,
      child: Column(
        children: [
          const Center(
              child: AssetProvider(
            asset: AssetConfig.kVerifyEmailPageImage,
            height: 250,
            width: 250,
          )),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 10,
            color: Colors.grey,
            width: MediaQuery.of(context).size.width / 1.3,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.circle,
                  color: kUniversalColor,
                ),
                Expanded(
                  child: Container(
                    height: 3,
                    color: kUniversalColor,
                  ),
                ),
                const Icon(
                  Icons.circle,
                  color: kUniversalColor,
                ),
                Expanded(
                  child: Container(
                    height: 3,
                    color: Colors.grey,
                  ),
                ),
                const Icon(
                  Icons.circle,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Order\nConfirmed",
                textAlign: TextAlign.center,
              ),
              Text(
                "Ready\nto Ship",
                textAlign: TextAlign.center,
              ),
              Text(
                "On\nthe way",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              height: 60,
                              width: 60,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("cartModel[i].title"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10,
                width: 80,
                color: Colors.grey,
              ),
              Container(
                height: 10,
                width: 60,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10,
                width: 100,
                color: Colors.grey,
              ),
              Container(
                height: 10,
                width: 60,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10,
                width: 80,
                color: Colors.grey,
              ),
              Container(
                height: 10,
                width: 90,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10,
                width: 100,
                color: Colors.grey,
              ),
              Container(
                height: 10,
                width: 80,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
