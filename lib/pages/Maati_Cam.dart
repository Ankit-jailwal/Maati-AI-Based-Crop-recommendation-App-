import 'dart:io' as Io;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ieeecrop/Weahter_API/resources/repository/remote/weather_api_provider.dart';
import 'package:ieeecrop/pages/Output_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:ieeecrop/Functions_and_route.dart';

//Create new event or edit existing event Screen
var _jsondata;

class CreateEventScreen extends StatefulWidget with DrawerStates {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final maxLines = 5;
  File _image;
  File path;
  String _base64;
  var _loc;

  Future get_image() async {
    final img = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = img;
      print(img.path);
      path = File(img.path);
      List<int> imageBytes = _image.readAsBytesSync();
      String imageB64 = base64Encode(imageBytes);
      //print(imageB64);
      _base64 = imageB64;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: get_image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _image == null
                          ? Image.asset(
                              'assets/images/cam.jpg',
                            )
                          : Image.file(_image),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FlatButton(
                          onPressed: () async {
                            var position = await Geolocator.getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.best);
                            String pos = (position.latitude).toString() +
                                "," +
                                (position.longitude).toString();
                            var res = await weatherApiProvider.fetchWeather1(
                                28.7041, 77.1025);
                            print(res);
                            var body = jsonDecode(res);
                            temp = (body['main']['temp']).toString();
                            String date = (DateTime.now()).toString();
                            print(pos);
                            print(date);
                            var data =
                                await crop_api_call(_base64, temp, date, pos);
                            print("data:$data");
                            print(data.runtimeType);
                            var json = jsonDecode(data);
                            print(json);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => output(json)),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                minHeight: 50, maxWidth: double.infinity),
                            child: Text(
                              "Get results",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class output extends StatelessWidget with DrawerStates {
  var js;
  output(this.js);
  final titles = [
    'bike',
    'boat',
    'bus',
    'car',
    'railway',
    'run',
    'subway',
    'transit'
  ];
  final image = [
    Icons.directions_boat,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
    Icons.directions_run,
    Icons.directions_subway,
    Icons.directions_transit
  ];
  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        appBar: AppBar(
          title: Text("Result"),
        ),
        body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Card(
                  //                           <-- Card widget
                  child: ListTile(
                    subtitle: Text(js['Data']['Crops'] ?? ""),
                    title: Text("Crop:"),
                    trailing:Image.asset("assets/crop.png")
                  ),
                ),
                Card(
                  //                           <-- Card widget
                  child: ListTile(
                    subtitle: Text(js['Data']['Fertilisers required'] ?? ""),
                    title: Text("Fertilisers required:"
                    ),
                    trailing: Image.asset("assets/fertilizer.png")
                  ),
                ),
                Card(
                  //                           <-- Card widget
                  child: ListTile(
                    subtitle: Text(js['Data']['Cost of cultivation'] ?? ""),
                    title: Text('Cost of cultivation:'),
                    trailing: Image.asset("assets/cul.png")
                  ),
                ),
                Card(
                  //                           <-- Card widget
                  child: ListTile(
                    subtitle: Text(js['Data']['Expected revenues'] ?? ""),
                    title: Text('Expected revenues:'),
                    trailing: Image.asset("assets/revenue.png")
                  ),
                ),
                Card(
                  //                           <-- Card widget
                  child: ListTile(
                    subtitle:
                        Text(js['Data']['Quantity of seeds per hectare'] ?? ""),
                    title: Text('Quantity of seeds per hectare:'),
                    trailing: Image.asset("assets/seed.png")
                  ),
                ),
                Card(
                  //                           <-- Card widget
                  child: ListTile(
                    subtitle: Text(js['Data']['Duration of cultivation'] ?? ""),
                    title: Text('Duration of cultivation:'),
                    trailing: Image.asset("assets/time.png")
                  ),
                ),
                Card(
                  //                           <-- Card widget
                  child: ListTile(
                    subtitle: Text(js['Data']['Demand of crop'] ?? ""),
                    title: Text('Demand of crop:'),
                    trailing: Image.asset("assets/demand.png")
                  ),
                ),
                Card(
                  //                           <-- Card widget
                  child: ListTile(
                    subtitle: Text(js['Data']['Crops for mixed cropping'] ?? ""),
                    title: Text('Crops for mixed cropping:'),
                    trailing:Image.asset("assets/mix.png")
                  ),
                ),
              ],
            ),
          );
        },
    ),
      );
  }
}
