import 'package:flutter/material.dart';
import 'package:notapp_backend/model/notedataModel.dart';

import '../constant/api_link.dart';

class cardNotes extends StatelessWidget {
  final void Function()? ontap;
  final NoteDataModel noteDataModel;
  void Function()? ondelete;
  cardNotes(
      {Key? key,
      required this.ontap,
      required this.noteDataModel,
      required this.ondelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${noteDataModel.image}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${noteDataModel.title}"),
                  subtitle: Text("${noteDataModel.content}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: ondelete,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
