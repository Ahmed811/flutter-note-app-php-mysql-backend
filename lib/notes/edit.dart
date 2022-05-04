import 'package:flutter/material.dart';
import 'package:notapp_backend/components/connect.dart';

import '../components/custom_text_form.dart';
import '../components/valid.dart';
import '../constant/api_link.dart';
import '../main.dart';

class Edit extends StatefulWidget {
  final note;
  const Edit({Key? key, required this.note}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> with Connect {
  @override
  void initState() {
    title.text = widget.note['title'];
    content.text = widget.note['content'];
    super.initState();
  }

  bool isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  editNote() async {
    // if (formstate.currentState!.validate()) {
    //   formstate.currentState!.save();
    isLoading = true;
    setState(() {});
    var response = await postRequest(linkUpdateNotes, {
      "title": title.text,
      "content": content.text,
      "image": "",
      "id": widget.note['id'].toString()
    });
    isLoading = false;
    setState(() {});
    print(response['status']);
    if (response['status'] == 'success') {
      Navigator.of(context).pushReplacementNamed('home');
    } else {
      print('insert note failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Form(
                      key: formstate,
                      child: Column(
                        children: [
                          CustomTextForm(
                              hint: 'title',
                              textEditingController: title,
                              valid: (val) {
                                return validInput(val!, 1, 20);
                              }),
                          CustomTextForm(
                              hint: 'content',
                              textEditingController: content,
                              valid: (val) {
                                return validInput(val!, 1, 255);
                              }),
                          MaterialButton(
                            onPressed: () async {
                              await editNote();
                            },
                            child: Text('Save'),
                            color: Colors.blue,
                          )
                        ],
                      ))
                ],
              ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
