import 'package:cankiri_burs_sorgulama/excel_function.dart';
import 'package:cankiri_burs_sorgulama/firebase_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
  var excel=ExcelFunction();
  print("excell readingg");
  excel.excelReader('assets/test.xlsx');

  excel.addDataFirebaseFromExcel('assets/test.xlsx');

}

final Future<FirebaseApp> initialization = Firebase.initializeApp();

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  TextEditingController tcText = TextEditingController();

  String sonuc = "";
  FirebaseFunction _firebaseFunction=FirebaseFunction();
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "burs sonucu",
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width/10*8,
              child: Center(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    const Center(
                        child: Text(
                      "Burs Sorgulama Sistemi",
                      style: TextStyle(fontSize: 25, color: Colors.pink),
                    )),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: tcText,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'TC Kimlik Numaranız',
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        width: 350,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.green),
                          child: const Text('Sonucu görüntüle'),
                          onPressed: () async {
                         var  data= await _firebaseFunction.getWinnerByTc(int.parse(tcText.text));
                            setState(()  {
                         sonuc= data;

                            });
                          },
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(sonuc.toUpperCase(),
                          style: const TextStyle(fontSize: 30, color: Colors.green)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
