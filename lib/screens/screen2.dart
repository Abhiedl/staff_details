import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pine_app/screens/screen3.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 2')),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('details').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              QuerySnapshot querySnapshot = streamSnapshot.data!;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;
              List<Map> details =
                  documents.map((e) => e.data() as Map).toList();
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  Map docDetails = details[index];

                  return Card(
                    child: ListTile(
                      minVerticalPadding: 35,
                      horizontalTitleGap: 30,
                      contentPadding: const EdgeInsets.only(left: 15),
                      title: Text(
                        '${docDetails['name']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${docDetails['ImageUrl']}',
                          ),
                          radius: 30),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Screen3(
                                  index: index,
                                  details: details,
                                )));
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
