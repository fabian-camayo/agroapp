import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'nav.dart';
import 'package:uuid/uuid.dart';
import 'upload_image.dart';
import 'global.Dart' as global;

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
var uuid = Uuid();

class _AddWidgetState extends State<Add> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String id = uuid.v4();
  String? name;
  String dropdownValue = "Tipo de Tema";
  bool? checkrequestvalue = true;
  bool? checkautovalue = true;
  String? content;
  getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> addTheme() async {
    await firestore
        .collection("themes")
        .add({
          'id': id,
          'url_img': global.img_url_temp,
          'name': name,
          'type': dropdownValue,
          'request': checkrequestvalue,
          'checkauto': checkautovalue,
          'content': content,
          'likes': [],
          'date_create': getCurrentDate(),
          'status': 'published'
        })
        .then((documentReference) {})
        .catchError((e) {
          print(e);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text('Crear Tema',
                  style: TextStyle(fontSize: 30), textAlign: TextAlign.center)),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xFF84cc16), // set border color
                    width: 1), // set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // set rounded corner radius
              ),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  hintText: 'Nombre del Tema',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  name = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Por favor ingrese un nombre";
                  }
                },
              )),
          Container(
              width: 400,
              height: 100,
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                Container(
                    width: 120,
                    height: 120,
                    margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: const Color(0xFF84cc16))))),
                      onPressed: () {
                        // Process data.
                        try {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadImage()),
                          ).then((value) => setState(() {}));
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("¡Ops! Error al subir imagen"),
                              content: Text('${e}'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text('Ok'),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      child: Center(
                          child: Text('Subir Imagen',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 22, color: Colors.grey))),
                    )),
                Container(
                    width: 100,
                    child: Image(
                      gaplessPlayback: true,
                      width: 100,
                      image: NetworkImage(global.img_url_temp),
                    ))
              ]),
              decoration: BoxDecoration()),
          Container(
              width: 400,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xFF84cc16), // set border color
                    width: 1), // set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // set rounded corner radius
              ),
              child: DropdownButton<String>(
                hint: new Text("Seleccione el tipo del tema"),
                isExpanded: true,
                value: dropdownValue,
                style: TextStyle(fontSize: 20, color: Colors.black45),
                items: <String>[
                  'Tipo de Tema',
                  'Siembra',
                  'Cosecha',
                  'Poscosecha'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue.toString();
                  });
                },
              )),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 2,
                  ), //SizedBox
                  Text(
                    'Permitir Edición              ',
                    style: TextStyle(fontSize: 17.0),
                  ), //Text
                  SizedBox(width: 2), //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: checkrequestvalue,
                    onChanged: (newValue) {
                      setState(() {
                        checkrequestvalue = newValue;
                      });
                    },
                  ), //Checkbox
                ], //<Widget>[]
              )), //Row
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 2,
                  ), //SizedBox
                  Text(
                    'Comprobación automatica ',
                    style: TextStyle(fontSize: 17.0),
                  ), //Text
                  SizedBox(width: 2), //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: checkautovalue,
                    onChanged: (newValue) {
                      setState(() {
                        checkautovalue = newValue;
                      });
                    },
                  ), //Checkbox
                ], //<Widget>[]
              )), //Row
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xFF84cc16), // set border color
                    width: 1), // set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // set rounded corner radius
              ),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  hintText: 'Contenido',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  content = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Por favor ingrese el contenido";
                  }
                },
              )),
          Container(
              width: 400,
              height: 50,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFF84cc16)),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                    try {
                      addTheme();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => NavBar(),
                        ),
                      );
                      global.img_url_temp =
                          'https://firebasestorage.googleapis.com/v0/b/agroapp-5a42d.appspot.com/o/upload%20img.png?alt=media&token=efb79419-3deb-43db-972c-44f53d0ccf75';
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("¡Ops! Error al publicar"),
                          content: Text('${e}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text('Ok'),
                            )
                          ],
                        ),
                      );
                    }
                  }
                },
                child: Text('Publicar', style: TextStyle(fontSize: 22)),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xFF84cc16), // set border color
                    width: 2.5), // set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // set rounded corner radius
              )),
        ],
      ),
    );
  }
}
