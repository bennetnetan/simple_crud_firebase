import 'package:flutter/material.dart';
import 'package:simple_crud_firebase/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // Firestore Object
  final FirestoreService firestoreService = FirestoreService();

  // Text controller
  final TextEditingController textController = TextEditingController();
  
  // create a dialogue box to add a note
  void openNoteBox(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Add a note'),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: 'Enter your note'),
      ),
      actions: [
        // button to save
        ElevatedButton(onPressed: () {
          // save the note
          firestoreService.addNote(textController.text);

          // Clear the text controller
          textController.clear();

          // Close the box
          Navigator.pop(context);
        },
         child: Text("Add"),
         ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white, letterSpacing: 2.0),
          ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        ),
    );
  }
}