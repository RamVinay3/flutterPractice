// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:googlesignin/google.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: TextButton(
//             onPressed: Google().GoogleLogin,
//             child: const Text('google sign in'),
//           ),
//         ),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wclpdrvsuieupxvgomls.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndjbHBkcnZzdWlldXB4dmdvbWxzIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTMzNzkwNDMsImV4cCI6MjAwODk1NTA0M30.SBdHAYzPCfTmnr6qGXVQEokczzY-UJG0xeptZwg4NOY',
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: MyWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<void> getData() async {
    final all = await supabase.from('balance').select();

    List pos = all.where((u) => u['type'] == 'pos').toList();
    List neg = all.where((u) => u['type'] == 'neg').toList();

    Map<String, dynamic> poss = {
      "chiranjeevi": 0,
      "shiva": 0,
      "vinay": 0,
      "samuel": 0,
      "nagasai": 0
    };
    for (int i = 0; i < pos.length; i++) {
      poss.forEach((key, val) {
        poss[key] = poss[key] + pos[i][key];
      });
    }

    Map<String, dynamic> negs = {
      "chiranjeevi": 0,
      "shiva": 0,
      "vinay": 0,
      "samuel": 0,
      "nagasai": 0
    };
    for (int i = 0; i < neg.length; i++) {
      negs.forEach((key, val) {
        negs[key] = negs[key] + neg[i][key];
      });
    }

    Map<String, dynamic> bal = {
      "chiranjeevi": 0,
      "shiva": 0,
      "vinay": 0,
      "samuel": 0,
      "nagasai": 0
    };
    bal.forEach((key, val) {
      bal[key] = poss[key] - negs[key];
    });

    print(bal);
  }

  Future<void> addData() async {
    await supabase.from("demo").insert({
      "payer": "chiranjeevi",
      "amount": 100,
      "chiranjeevi": 20,
      "vinay": 20,
      "shiva": 20,
      "samuel": 20,
      "nagasai": 20
    });
    await supabase.from("balance").insert([
      {"type": "pos", "chiranjeevi": 100},
      {
        "type": "neg",
        "chiranjeevi": 20,
        "vinay": 20,
        "shiva": 20,
        "samuel": 20,
        "nagasai": 20
      }
    ]);
  }

  Future<void> updateData() async {
    await supabase
        .from("history")
        .update({"amount": 500}).match({"payer": "Shiva"});
  }

  Future<void> deleteData() async {
    await supabase.from("history").delete().match({"payer": "Vinay"});
  }

  List<Widget> getWidgets(List data) {
    getData();
    List<Widget> a = [];
    for (int i = 0; i < data.length; i++) {
      a.add(Text(data[i]['payer'].toString()));
    }
    return a;
  }

  void display(List data) {
    for (int i = 0; i < data.length; i++) {
      print(data[i]['payer']);
    }
    // print(data[0]['payer']);
  }

  final stream = supabase.from('history').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Example'),
        ),
        body: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                List _snapshot = snapshot.data as List;
                // display(_snapshot);
                return Column(
                  children: getWidgets(_snapshot),
                );
              } else {
                return Text("Data is not present");
              }
            }));
  }
}
