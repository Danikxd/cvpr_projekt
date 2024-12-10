
import 'package:cvpr_projekt/persistent/firebase_api.dart';
import 'package:cvpr_projekt/utils/date_parse.dart';
import 'package:flutter/material.dart';

class CreateBookPage extends StatefulWidget {
  const CreateBookPage({super.key});

  @override
  State<CreateBookPage> createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
   

    TextEditingController titleController = TextEditingController();
    TextEditingController authorController = TextEditingController();
    TextEditingController pageCountController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController imageUrlController = TextEditingController();
    TextEditingController publisherController = TextEditingController();
    TextEditingController publishedDateController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Book'),
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: 
      Form(
        key: _formKey,
        child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title*',
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            controller: authorController,
            decoration: const InputDecoration(
              labelText: 'Author*',
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Please enter an author';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            controller: pageCountController,
            decoration: const InputDecoration(
              labelText: 'Page count',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if(value == null) return null;
              if(int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),

          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          TextFormField(
            controller: imageUrlController,
            decoration: const InputDecoration(
              labelText: 'Image URL',
            ),
          ),
          TextFormField(
            controller: publisherController,
            decoration: const InputDecoration(
              labelText: 'Publisher*',
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Please enter a publisher';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            controller: publishedDateController,
            decoration: const InputDecoration(
              labelText: 'Published Date*',
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Please enter a published date';
              }
              try {
                DateParse.parse(value);
              } catch(e) {
                return 'Please enter a valid date (format: yyyy-mm-dd)';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          ElevatedButton(
            onPressed: () async {
              if(titleController.text.isEmpty || authorController.text.isEmpty || publisherController.text.isEmpty || publishedDateController.text.isEmpty || !_formKey.currentState!.validate()) {
                return;
              }
              FirebaseApi.instance.createBook(
                titleController.text,
                authorController.text,
                int.tryParse(pageCountController.text),
                descriptionController.text,
                imageUrlController.text,
                publisherController.text,
                publishedDateController.text
              );
            },
            child: const Text('Create'),
          ),
        ],
      ))
          
         
        
      ),
    );
  }
}