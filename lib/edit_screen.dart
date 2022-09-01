import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireblog_test/firebase.dart';
import 'package:flutter/material.dart';
import 'firemodel.dart';

class EditScreen extends StatelessWidget {
  final FireModel fireModel;
  EditScreen({Key? key, required this.fireModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: '${fireModel.motto}');

    return Scaffold(
      appBar: AppBar(title: const Text('EDIT SCREEN'),),
      body: Row(
        children: [
          Expanded(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: 'input message',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                    )
                ),
              )
          ),
          TextButton(
              onPressed: (){
                FireModel updateModel = FireModel(motto: controller.text, date: Timestamp.now());
                FireService().updateMemo(reference: fireModel.reference!, json: updateModel.toJson());
                Navigator.of(context).pop(true);
              },
              child: const Icon(Icons.send)
          )
        ],
      ),
    );
  }
}
