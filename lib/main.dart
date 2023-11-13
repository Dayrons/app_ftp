import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ftpconnect/ftpconnect.dart';

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
  const MyHomePage({super.key});

  void _connect()async{
    FTPConnect ftpConnect = FTPConnect('10.10.10.85', port: 2121,user:'user', pass:'password');
    File fileToUpload = File('file.txt');
    await ftpConnect.connect();
    bool res = await ftpConnect.uploadFileWithRetry(fileToUpload, pRetryCount: 2);
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