import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notapp_backend/components/card_notes.dart';
import 'package:notapp_backend/components/connect.dart';
import 'package:notapp_backend/main.dart';
import 'package:notapp_backend/model/notedataModel.dart';
import 'package:notapp_backend/notes/edit.dart';
import 'constant/api_link.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Connect {
  // @override
  // void initState() {
  //   getNotes();
  //   super.initState();
  // }

  getNotes() async {
    // List ids = [];
    var response = await postRequest(
        linkReadNotes, {"notes_users": sharedPref.getString("id").toString()});

    print('=============$response');
    // print(ids);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          // IconButton(
          //     onPressed: () async {
          //       setState(() {});
          //       await getNotes();
          //     },
          //     icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: getNotes(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data['status'] == 'fails') {
                return Center(
                  child: Text("لا يوجد ملاحظات لعرضها"),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data['notedata'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardNotes(
                        ondelete: () async {
                          var response = await postRequest(linkDeleteNotes, {
                            "id": snapshot.data['notedata'][index]['id']
                                .toString()
                          });
                          if (response['status'] == 'success') {
                            Navigator.pushReplacementNamed(context, 'home');
                          }
                        },
                        ontap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Edit(
                                  note: snapshot.data['notedata'][index])));
                        },
                        noteDataModel: NoteDataModel.fromJson(
                            snapshot.data['notedata'][index]),
                      );
                    });
              }

              return Text('Loading........');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
