import 'package:flutter/material.dart';
import 'package:set_point_attender/menus/client_type_menu.dart';
import 'package:set_point_attender/menus/settings_menu.dart';
import 'package:set_point_attender/models/database.dart';
import 'package:set_point_attender/shared/parse_names.dart';

class AddNewClientWorker extends StatefulWidget {
  @override
  _AddNewClientWorkerState createState() => _AddNewClientWorkerState();
}

class _AddNewClientWorkerState extends State<AddNewClientWorker> {
  final controllerForClientName = TextEditingController();
  String clientType;

  @override
  void dispose() {
    controllerForClientName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    clientType = "";
    controllerForClientName.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: LogoutBurgerWidget(),
            )
          ],
          title: Text("הוספת לקוח חדש"),
          elevation: 0.0,
        ),
        body: Center(
          child: clientType == ""
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 28.0),
                    Text("קטגוריה:",
                        style: TextStyle(
                            fontSize: 28.0,
                            decoration: TextDecoration.underline)),
                    SizedBox(height: 28.0),
                    ClientTypeMenu(updateParent: updateClientType),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        color: Colors.grey[300],
                        label: Text("להחלפה", style: TextStyle(fontSize: 18.0)),
                        icon: Icon(Icons.restore_page),
                        onPressed: () {
                          setState(() {
                            clientType = "";
                            controllerForClientName.clear();
                          });
                        },
                      ),
                      Divider(height: 5.0),
                      Text(
                        "שם $clientType להוספה",
                        style: TextStyle(fontSize: 28.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 28.0),
                          controller: controllerForClientName,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 5.0),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Colors.amber,
                          onPressed: () {
                            Database.addNewClient(
                                clientTypeToEnglish(clientType),
                                controllerForClientName.text);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                    "${controllerForClientName.text} נוסף בהצלחה",
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                );
                              },
                            );
                            setState(() {
                              clientType = "";
                              controllerForClientName.clear();
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Text(
                            "הוספה",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }

  updateClientType(String k) {
    setState(() => clientType = k);
  }
}
