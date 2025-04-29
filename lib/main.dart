import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_aggregator/pages/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');

  // ByteData data = await rootBundle.load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(const MainApp());
}


// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port){
//       // Allowing only our Base API URL.
//       List<String> validHosts = [myApiUrl];
      
//       final isValidHost = validHosts.contains(host);
//       return isValidHost;
      
//       // return true if you want to allow all host. (This isn't recommended.)
//       // return true;
//     };
//   }
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}
