import 'dart:async';
import 'dart:math';
import 'package:fireapp/firebase_options.dart';
import 'package:fireapp/view/status_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';


void main() async {

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
      child: const Home()
  )
  );
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
        home: StatusPage()
    );
  }
}



class Counter extends StatefulWidget {

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
 StreamController numberStream = StreamController<int>();

late Stream st;


Stream<int> getData () async* {

  while(true){
    await Future.delayed(Duration(seconds: 1));
    yield Random().nextInt(100) + 1;
  }

}

 @override
  void initState() {
    st = numberStream.stream.asBroadcastStream();
    super.initState();
  }

int n = 0;

  @override
  Widget build(BuildContext context) {
print('build');
    st.listen((event) {
      print(event);
    });
    return Scaffold(
        body: Center(
            child:StreamBuilder(
              stream:  getData(),
              builder: (context, snapshot) {
                print(snapshot.data);
                return Text(snapshot.data.toString());
              }
            )
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){

          },
        child: IconButton(onPressed: (){
          numberStream.sink.add(n++);
        }, icon: Icon(Icons.add)),
      ),
    );
  }
}


