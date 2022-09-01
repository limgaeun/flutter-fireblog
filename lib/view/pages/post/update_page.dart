import 'package:fireblog_test/controller/post_controller.dart';
import 'package:fireblog_test/util/validators.dart';
import 'package:fireblog_test/view/components/custom_elevated_button.dart';
import 'package:fireblog_test/view/components/custom_text_form_field.dart';
import 'package:fireblog_test/view/components/custom_textarea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PostController p = Get.find();
    _title.text = '${p.post.value.title}';
    _content.text = '${p.post.value.content}';

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: _title,
                hint: "Title",
                funValidator: validateTitle(),
              ),
              CustomTextArea(
                controller: _content,
                hint: "Content",
                funValidator: validateContent(),
              ),
              // homepage -> detailpage -> detailpage
              CustomElevatedButton(
                text: "글 수정하기",
                funPageRoute: () async {
                  if (_formKey.currentState!.validate()) {
                    await p.updateById(p.post.value.id ?? '0', _title.text, _content.text);
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}