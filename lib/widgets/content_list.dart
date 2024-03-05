import 'package:flutter/material.dart';
import 'package:mova/utils/db.dart';

class ContentList extends StatefulWidget {
  const ContentList({super.key});

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  final Future<String> _calculation = helloWorld();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Український правопис"),
      ),
      body: FutureBuilder<String>(
       future: _calculation, // a previously-obtained Future<String> or null
       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
         List<Widget> children;
         if (snapshot.hasData) {
           children = <Widget>[
             Padding(
               padding: const EdgeInsets.only(top: 10),
               child: Text('${snapshot.data}'),
             ),
           ];
         } else if (snapshot.hasError) {
           children = <Widget>[
             const Icon(
               Icons.error_outline,
               color: Colors.red,
               size: 60,
             ),
             Padding(
               padding: const EdgeInsets.only(top: 16),
               child: Text('Error: ${snapshot.error}'),
             ),
           ];
         } else {
           children = const <Widget>[
             SizedBox(
               width: 60,
               height: 60,
               child: CircularProgressIndicator(),
             ),
             Padding(
               padding: EdgeInsets.only(top: 16),
               child: Text('Awaiting result...'),
             ),
           ];
         }
         return Column(
           children: children,
         );
       },
            ),
    );
  }
}
