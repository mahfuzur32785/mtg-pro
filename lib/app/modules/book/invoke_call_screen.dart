
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvokeCallScreen extends StatefulWidget {
  const InvokeCallScreen({Key? key}) : super(key: key);

  @override
  State<InvokeCallScreen> createState() => _InvokeCallScreenState();
}

class _InvokeCallScreenState extends State<InvokeCallScreen> {

  String counter = '';
  String rand = '';
  static const platform = MethodChannel('example.com/channel');

  Future<void> generateRandomNumber() async {
    String random = '';
    try {
      random = await platform.invokeMethod('getRandomString');
      if (kDebugMode) {
        print(random);
      }
    } on PlatformException catch (e) {
      random = '';
    }
    setState(() {
      counter = random;
    });
  }

  Future<void> generateRandomStringArg() async {
    String random = '';
    try {
      var arguments = {
        "len": 7,
        "prefix": 'pl_'
      };
      random = await platform.invokeMethod('getRandomStringArg',arguments);
      if (kDebugMode) {
        print(random);
      }
    } on PlatformException catch (e) {
      random = '';
    }
    setState(() {
      rand = random;
    });
  }

  int computeFunction(int finalNum) {
    int count = 0;
    for (int i = 0; i < finalNum; i++) {
      count++;
      if ((count % 100) == 0) {
        if (kDebugMode) {
          print("compute: $count");
        }
      }
    }
    return count;
  }

  Future<void> runCompute() async {
    int count = 0;
    count = await compute (computeFunction, 2000);
    if (kDebugMode) {
      print("finally compute value : $count");
    }
    // setState(() {});
  }

  void isolateFunction (int finalNum) {
    int count = 0;
    for (int i = 0; i < finalNum; i++) {
      count++;
      if((count % 100) == 0) {
        if (kDebugMode) {
          print("isolate: $count");
        }
      }
    }
  }

  @override
  void initState() {
    // Isolate.spawn(isolateFunction, 1000);
    // runCompute();
    super.initState();
  }

  final int max = 10;
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Native Code Run",style: TextStyle(color: Colors.black87),),
      ),
      // body: Center(
      //   child: Text("The random number is : $rand"),
      // ),
        body: Builder(
          key: Key('builder ${selected.toString()}'),
          builder: (context){
            return ListView(
              children: <Widget>[
                for(int i = 0; i < max; i++)
                  ExpansionTile(
                    key: Key(i.toString()),
                    title: Text('Tile ${i+1}'),
                    initiallyExpanded: i==selected,
                    onExpansionChanged: (expanded){
                      if(expanded) {
                        setState(() {
                          selected = i;
                        });
                      } else {
                        setState(() {
                        selected = -1;
                      });
                      }
                    },
                    children: [
                      Container(
                        height: 100,
                        width: 200,
                        color: Colors.primaries[i],
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  )
              ],
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // generateRandomNumber();
          // generateRandomStringArg();
          // runCompute();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
