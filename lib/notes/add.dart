import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notapp_backend/components/connect.dart';
import 'package:notapp_backend/components/custom_text_form.dart';
import 'package:notapp_backend/main.dart';
import 'package:image_picker/image_picker.dart';
import '../components/valid.dart';
import '../constant/api_link.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> with Connect {
  File? myFile;
  bool isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  addNote() async {
    // if (formstate.currentState!.validate()) {
    //   formstate.currentState!.save();
    if (myFile == null) {
      return AwesomeDialog(
          context: context,
          title: "لا يوجد صورة",
          body: Text("يرجي اختيار صورة قبل حفظ الملاحظة"))
        ..show();
    }
    isLoading = true;
    setState(() {});
    var response = await postRequestWithFile(
        linkWriteNotes,
        {
          "title": title.text,
          "content": content.text,
          "image": "",
          "id": sharedPref.getString("id")
        },
        myFile!);
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
        decoration: BoxDecoration(),
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
                          myFile == null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  width: 200,
                                  height: 200,
                                  child: Text("لا يوجد صورة لعرضها"),
                                )
                              : Image.file(
                                  myFile!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                          MaterialButton(
                            onPressed: () async {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                        height: 100,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Choose Image From",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton.icon(
                                                    onPressed: () async {
                                                      XFile? xfile =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                      myFile =
                                                          File(xfile!.path);
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                    icon: Icon(
                                                        Icons.browse_gallery),
                                                    label: Text(
                                                      "Gallery",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )),
                                                TextButton.icon(
                                                    onPressed: () async {
                                                      XFile? xfile =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);
                                                      myFile =
                                                          File(xfile!.path);
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                    icon: Icon(Icons.camera),
                                                    label: Text(
                                                      "Camera",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )),
                                                // Container(
                                                //     padding: EdgeInsets.all(10),
                                                //     child: MaterialButton(
                                                //       child: Text(
                                                //         "Gallery",
                                                //         style: TextStyle(
                                                //             fontSize: 20),
                                                //       ),
                                                //       onPressed: () {},
                                                //     )),
                                                // Container(
                                                //     padding: EdgeInsets.all(10),
                                                //     child: MaterialButton(
                                                //       child: Text(
                                                //         "Camera",
                                                //         style: TextStyle(
                                                //             fontSize: 20),
                                                //       ),
                                                //       onPressed: () {},
                                                //     ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                            },
                            child: Text('choose image'),
                            color: Colors.blue,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              await addNote();
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
