import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'nav.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('themes');
final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

class _SearchWidgetState extends State<Search> {
  static Stream<QuerySnapshot> searchByName(String searchField) {
    return _mainCollection.where("name", isEqualTo: searchField).snapshots();
  }

  var searchvalue = "";
  getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  String inputData() {
    final User? user = auth.currentUser;
    return user!.uid;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                onChanged: (val) {
                  searchvalue = val;
                },
                decoration: InputDecoration(
                  hintText: "Buscar por nombre",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.search),
                    onPressed: () {
                      print("Se esta buscando");
                      print(searchvalue);
                      setState(() {
                        searchByName(searchvalue);
                      });
                      ;
                    },
                  ),
                ),
                style: TextStyle(color: Colors.grey),
              )),
          actions: <Widget>[],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: searchByName(searchvalue),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                'Error al cargar los temas',
                style: TextStyle(color: Colors.black),
              );
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                separatorBuilder: (context, index) => SizedBox(height: 16.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var themeInfo =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  String themeID = snapshot.data!.docs[index].id;
                  String name = themeInfo['name'];
                  String content = themeInfo['content'];
                  String like = themeInfo['likes'].length.toString();
                  print("likes");
                  return Ink(
                    decoration: BoxDecoration(
                        color: const Color(0xFFe9ffc9),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onTap: () {
                        print("Clic al thema");
                        print(themeID);
                        print(themeInfo);
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            elevation: 5,
                            context: context,
                            builder: (context) => Padding(
                                  padding: EdgeInsets.all(15),
                                  child: ListView(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text('Tema',
                                              style: TextStyle(fontSize: 30),
                                              textAlign: TextAlign.center)),
                                      Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: const Color(
                                                    0xFF84cc16), // set border color
                                                width: 1), // set border width
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    10.0)), // set rounded corner radius
                                          ),
                                          child: TextFormField(
                                            readOnly: true,
                                            initialValue: name,
                                            keyboardType: TextInputType.name,
                                            style: TextStyle(fontSize: 20),
                                            decoration: InputDecoration(
                                              labelText: 'Nombre',
                                              border: InputBorder.none,
                                            ),
                                          )),
                                      Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: const Color(
                                                    0xFF84cc16), // set border color
                                                width: 1), // set border width
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    10.0)), // set rounded corner radius
                                          ),
                                          child: TextFormField(
                                            readOnly: true,
                                            initialValue: themeInfo['type'],
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(fontSize: 20),
                                            decoration: InputDecoration(
                                              labelText: 'Tipo de Tema',
                                              border: InputBorder.none,
                                            ),
                                          )),
                                      Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: const Color(
                                                    0xFF84cc16), // set border color
                                                width: 1), // set border width
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    10.0)), // set rounded corner radius
                                          ),
                                          child: TextFormField(
                                            readOnly:
                                                themeInfo['request'] == true
                                                    ? false
                                                    : true,
                                            maxLines: null,
                                            initialValue: themeInfo['content'],
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextStyle(fontSize: 20),
                                            decoration: InputDecoration(
                                              labelText: 'Contenido',
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
                                      SizedBox(),
                                      Visibility(
                                          visible: themeInfo['request'] == true
                                              ? true
                                              : false,
                                          child: Container(
                                              width: 400,
                                              height: 50,
                                              margin: const EdgeInsets.fromLTRB(
                                                  20, 20, 20, 5),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: const Color(
                                                              0xFF84cc16)),
                                                  onPressed: () async {
                                                    // Process data.
                                                    try {
                                                      await _firestore
                                                          .collection("themes")
                                                          .doc(themeID)
                                                          .update({
                                                            'content': content,
                                                            'likes': 0,
                                                            'date_update':
                                                                getCurrentDate(),
                                                          })
                                                          .then(
                                                              (documentReference) {})
                                                          .catchError((e) {
                                                            print(e);
                                                          });
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (contex) =>
                                                              NavBar(),
                                                        ),
                                                      );
                                                    } catch (e) {}
                                                  },
                                                  child: Text(
                                                      'Editar Publicaci??n',
                                                      style: TextStyle(
                                                          fontSize: 22)))))
                                    ],
                                  ),
                                ));
                      },
                      title: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: TextButton.icon(
                          onPressed: () async {
                            try {
                              print("entra al like");
                              var status = true;
                              var listlikes = themeInfo['likes'];
                              print("status");
                              print(status);
                              if (listlikes.length == 0) {
                                status = true;
                              } else {
                                for (var i = 0; i <= listlikes.length; i++) {
                                  print(listlikes[i]);
                                  if (listlikes[i] == inputData().toString()) {
                                    print("ya dio like");
                                    status = false;
                                    /**Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (contex) => NavBar(),
                                      ),
                                    );**/
                                  }
                                }
                              }
                              print("status");
                              print(status);

                              if (status) {
                                print("No ha dado like");
                                listlikes.add(inputData());
                                await _firestore
                                    .collection("themes")
                                    .doc(themeID)
                                    .update({
                                      'likes': listlikes,
                                    })
                                    .then((documentReference) {})
                                    .catchError((e) {
                                      print(e);
                                    });
                                /**Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (contex) => NavBar(),
                                  ),
                                );**/
                              }
                            } catch (e) {}
                          },
                          icon: Icon(Icons.favorite),
                          label: Text(
                            like,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                  );
                },
              );
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ));
          },
        ));
  }
}
