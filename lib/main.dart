import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  
  return directory.path;
}



  const MyHomePage({super.key});


  List<Map>_getPasswords(){
    return [
    {
      "titulo":"Provincial",
      "password":"123456",
    },
    {
      "titulo":"Venezuela",
      "password":"123456",
    },
    {
      "titulo":"Mercantil",
      "password":"123456",
    },
    {
      "titulo":"Binance",
      "password":"123456",
    },
    {
      "titulo":"Banca Amiga",
      "password":"123456",
    },
    {
      "titulo":"Paypal",
      "password":"123456",
    },
    {
      "titulo":"Provincial",
      "password":"123456",
    },
  ];
  }

  void _connect()async{
    FTPConnect ftpConnect = FTPConnect('10.10.10.85', port: 2121,user:'user', pass:'password');
    final path = await _localPath;
    File file = File('$path/password.txt');
    file.writeAsString( json.encode(_getPasswords()));
    await ftpConnect.connect();
    bool res = await ftpConnect.uploadFileWithRetry(file, pRetryCount: 2);
    await ftpConnect.disconnect();
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Center(child: IconButton(
          icon:  const Icon(Icons.add),
          tooltip: 'enviar archivo',
          onPressed: _connect,
        ),),
    );
  }
}