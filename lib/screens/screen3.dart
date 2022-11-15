import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  final int index;
  final List<Map<dynamic, dynamic>> details;
  Screen3({
    super.key,
    required this.index,
    required this.details,
  });

  final _stream = FirebaseFirestore.instance.collection('images');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 3'),
      ),
      body: StreamBuilder(
        stream: _stream.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Map docDetails = details[index];
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      '${docDetails['ImageUrl']}',
                    ),
                    maxRadius: 75,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '${docDetails['name']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Age : ${docDetails['age']}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Mobile : ${docDetails['phone']}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Department : ${docDetails['department']}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
