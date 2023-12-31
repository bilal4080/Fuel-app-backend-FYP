// ignore_for_file: deprecated_member_use, sort_child_properties_last, prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, avoid_print, unused_local_variable, unnecessary_null_comparison, unused_import, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:app/user/location_controller.dart';
import 'package:app/user/order_controller.dart';
import 'package:app/user/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class order extends StatefulWidget {
  @override
  createState() => _OrderScreenState();
}

class _OrderScreenState extends State<order> {
  final TextEditingController carNoController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController =
      TextEditingController(text: LocationController().currentLocation);
  final TextEditingController fuleQuintityController = TextEditingController();
  String? fuelType = "Petrol";
  bool isOrderForYourselfActive = true;
  int selectedFuelType = 0;
  int? indexx;
  int selectedFuelStation = 0;
  int quantity = 0;
  User? user = FirebaseAuth.instance.currentUser;
  String? station;
  String? userId;

  void increaseQuantity() {
    if (quantity < 10) {
      setState(() {
        quantity++;
      });
    }
  }

  void decreaseQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  void initState() {
    print("fuelType$fuelType");
    userId = user!.uid;
    super.initState();
  }

  bool isOrderReady() {
    var phoneno = phoneController.text;
    var address = addressController.text;
    var carno = carNoController.text;
    var addressstatoion = OrderController().address;
    var station = OrderController().station;

    return phoneno.isNotEmpty &&
        address.isNotEmpty &&
        carno.isNotEmpty &&
        fuelType != null &&
        quantity > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Order Fuel',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isOrderForYourselfActive = true;
                              });
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isOrderForYourselfActive
                                      ? Colors.orange
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: Color(0xffF6F6F6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.car_rental,
                                    size: 40,
                                    color: isOrderForYourselfActive
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Self',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isOrderForYourselfActive
                                          ? Colors.orange
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isOrderForYourselfActive = false;
                              });
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: !isOrderForYourselfActive
                                      ? Colors.orange
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: Color(0xffF6F6F6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.people,
                                    size: 40,
                                    color: !isOrderForYourselfActive
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Other',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: !isOrderForYourselfActive
                                          ? Colors.orange
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Text(
                      //   'Order Detail',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w200,
                      //   ),
                      // ),

                      Text(
                        'Order Detail',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: carNoController,
                        decoration: InputDecoration(
                          hintText: 'Enter your Name here',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: carNoController,
                        decoration: InputDecoration(
                          hintText: 'Type your Car Number here',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: 'Type your contact no here',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a number only';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          hintText: 'Type your address here',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Fuel Type',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                fuelType = "Petrol";
                                print("fuelType$fuelType");
                                selectedFuelType = 0;
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedFuelType == 0
                                      ? Colors.orange
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: Color(0xffF6F6F6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_gas_station,
                                    size: 30,
                                    color: selectedFuelType == 0
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Petrol',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: selectedFuelType == 0
                                          ? Colors.orange
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                fuelType = "Gasoline";
                                print("fuelType$fuelType");
                                selectedFuelType = 1;
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedFuelType == 1
                                      ? Colors.orange
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: Color(0xffF6F6F6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.electric_car_outlined,
                                    size: 30,
                                    color: selectedFuelType == 1
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'High Octane',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: selectedFuelType == 1
                                          ? Colors.orange
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                fuelType = "Diesel";
                                print("fuelType$fuelType");
                                selectedFuelType = 2;
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedFuelType == 2
                                      ? Colors.orange
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: Color(0xffF6F6F6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_gas_station,
                                    size: 30,
                                    color: selectedFuelType == 2
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Diesel',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: selectedFuelType == 2
                                          ? Colors.orange
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Existing code...
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 250,
                        child: Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('stations')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              List<QueryDocumentSnapshot> documents =
                                  snapshot.data!.docs;

                              if (documents.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No fuel station yet.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }

                              return ListView.separated(
                                shrinkWrap: true,
                                itemCount: documents.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(); // Add a divider between items.
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  QueryDocumentSnapshot document =
                                      documents[index];
                                  Map<String, dynamic>? data =
                                      document.data() as Map<String, dynamic>?;
                                  var name = data?['name'];
                                  var address = data?['address'];
                                  // Wrap the Container representing each fuel station with GestureDetector
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexx = index;
                                        print("index$index");
                                        OrderController().location = address;
                                        OrderController().station = name;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: indexx == index
                                              ? Colors.orange
                                              : Colors.grey,
                                          width: 2,
                                        ),
                                        color: Color(0xffF6F6F6),
                                      ),
                                      child: Card(
                                        elevation: 2,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: ListTile(
                                          leading:
                                              Icon(Icons.local_gas_station),
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(
                                            address,
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          trailing: Text(
                                            'Distance ${index + 1} km',
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),

// Existing code...

                      SizedBox(height: 20),
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: decreaseQuantity,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                  color: Colors.orange,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                '$quantity liters',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: increaseQuantity,
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 30,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (isOrderReady()) {
                            OrderController().phoneno = phoneController.text;
                            OrderController().address = addressController.text;
                            OrderController().carno = carNoController.text;
                            OrderController().fuelType = fuelType;
                            OrderController().quantity = quantity;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Paymet_next(
                                  fuelAmount: 1,
                                  fuelType: '',
                                ),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please fill all fields",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.orange,
                              textColor: Colors.white,
                            );
                          }
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: isOrderReady() ? Colors.white : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: isOrderReady()
                              ? Colors.orangeAccent
                              : const Color.fromARGB(255, 213, 206, 206),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
