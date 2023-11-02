

import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

import 'firebase_function.dart';





class ExcelFunction{

  FirebaseFunction _firebaseFunction=FirebaseFunction();



  excelReader(String excelRoot) async {


    ByteData data = await rootBundle.load(excelRoot);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {


      for (var row in excel.tables[table]!.rows) {
        var concatenatedValues = '${row[0]?.value} ${row[1]?.value} ${row[2]?.value}';
        print(concatenatedValues);
       // print("${row.map((e) => e?.value)}");
      //   print('$row');
      }
    }


  }
  addDataFirebaseFromExcel(String excelRoot) async {
    ByteData data = await rootBundle.load(excelRoot);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {


      for (var row in excel.tables[table]!.rows) {
        //var concatenatedValues = '${row[0]?.value} ${row[1]?.value} ${row[2]?.value}';
        //print(concatenatedValues);
        // print("${row.map((e) => e?.value)}");
        //   print('$row');
        var tc=row[0]?.value.toString();
        var name=row[1]?.value.toString();
        var surname=row[2]?.value.toString();

      await  _firebaseFunction.addFirebaseWinner(name!, surname!, int.parse(tc!));



      }
    }



  }

}