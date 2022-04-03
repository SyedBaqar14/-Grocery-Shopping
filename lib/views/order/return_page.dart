import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/orders/orders_cubit.dart';
import 'package:grocery_shopping/utils/config/asset_config.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:win32/winsock2.dart';
class ReturnPage extends StatefulWidget {
  @override
  _ReturnPageState createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {

  List<String> dropDownList = [
    "Some Reason",
    "Some Reason1",
    "Some Reason2",
    "Some Reason3",
    "Some Reason4",
    "Some Reason5"
  ];

  String selectedValue = "Some Reason";
  int index = 2000;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: BackButton(color: kUniversalColor,),
            backgroundColor: Colors.white,
            title: Text("Return",style: TextStyle(color: Colors.black),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(AssetConfig.kReturnVector)),
                  SizedBox(height: 30,),
                  Text("Order Details",style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  const Text("Order Number*"),
                  Text("${state.trackOrderResult!
            .data?['getOrder']['id']
        .
        toString
        (
        )
      }",style: const TextStyle(color: kUniversalColor),),
                  const Divider(color: kUniversalColor,thickness: 1,),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            onChanged: (v){},
                            groupValue: 1,
                          ),
                          Text("Return Full Order"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: kUniversalColor,
                            value: 1,
                            onChanged: (v){},
                            groupValue: 1,
                          ),
                          Text("Return Specific Product"),
                        ],
                      )
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.trackOrderResult!
                        .data?['getOrder']['order_products'].length,
                    itemBuilder: (ctx, i) {
                      var d = state.trackOrderResult!.data?['getOrder']
                      ['order_products'][i];
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                        ),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              index = i;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: index == i ? Border.all(
                                color:  kUniversalColor,
                              ) :Border.all(width: 0,style: BorderStyle.none),
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    d['product']
                                                    ['image']))),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(d['name']),
                                          Row(
                                            children: [
                                              Text(
                                                "Rs ${d['price']}",
                                                style:
                                                GoogleFonts.montserrat(
                                                    color:
                                                    kUniversalColor),
                                              ),
                                              Text(
                                                "/kg",
                                                style:
                                                GoogleFonts.montserrat(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Text("Reason for Return*"),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: selectedValue,
                    items: dropDownList.map((e){
                      return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e));
                    }).toList(),
                    onChanged: (va){
                      setState(() {
                        selectedValue = va.toString();
                      });
                    },
                  ),
                  Text("Message*"),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Type Message"
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Your Details",style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  Text("Name"),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "your name"
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Email"),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "XX@XXX.com"
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Phone"),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "03XX-XXXXXXX"
                    ),
                  ),
                  SizedBox(height: 30,),
                  MaterialButton(
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: (){},
                    color: kUniversalColor,
                    child: Text("Send Request",style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
