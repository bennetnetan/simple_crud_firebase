import 'package:cloud_firestore/cloud_firestore.dart';
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
  void openNoteBox({String? docId}){
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
          if (docId == null) {
            firestoreService.addNote(textController.text);
          } else {
            firestoreService.updateNotes(docId, textController.text);
          }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(), 
        builder: (context, snapshot) {
          // If we have data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // Display as a list view
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder:  (context, index) {
                // Get the individual document
                DocumentSnapshot document = notesList[index];
                String docId = document.id;

                // Get the note from each document
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // display as a list tile
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Update button
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () => openNoteBox(docId: docId),
                      ),
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => firestoreService.deleteNotes(docId),
                        ),
                    ],
                  ),
                );
              }
            );
          } 
          // If there is no data return no nothing
          else {
            return const Text(
              "There are no notes...", 
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black54,
                letterSpacing: 1.5,
                ),
              );
          }
        }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        ),
    );
  }
}