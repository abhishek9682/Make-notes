import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/note_model.dart';

class By_text extends StatefulWidget {
  final List<NoteModel> notes;
  const By_text({super.key, required this.notes});

  @override
  State<By_text> createState() => _By_textState();
}

class _By_textState extends State<By_text> {

  TextEditingController topic=TextEditingController();
  TextEditingController date=TextEditingController();
  TextEditingController note=TextEditingController();

  void _saveNote() {
    if (topic.text.isEmpty || note.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter topic and details")),
      );
      return;
    }

    // ✅ Create NoteModel object
    final newNote = NoteModel(
      topic: topic.text,
      date: date.text.isEmpty
          ? DateTime.now().toString().substring(0, 16)
          : date.text,
      details: note.text,
    );

    setState(() {
      widget.notes.add(newNote); // ✅ Add to shared notes list
    });

    // clear fields
    topic.clear();
    date.clear();
    note.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Note added successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.edit_note),
      //   centerTitle: true,
      //   backgroundColor: Colors.cyanAccent,
      //   title: Text(
      //     " Write Note",style: TextStyle(fontSize: 30),
      //   ),
      // ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Card(
              shadowColor: Colors.black12,
              surfaceTintColor: Colors.black,
              margin: EdgeInsets.only(left: 10),
              color: Colors.teal,
              child: Center(child: Text("write notes here".toUpperCase(),style: TextStyle(fontSize: 35),)),
            ),

            SizedBox(height: 50,),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                  blurRadius: 4,
                      spreadRadius:3,
                    color: Colors.grey.withOpacity(0.5),
                ),
                ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: TextField(
                controller: topic,
                decoration: InputDecoration(
                  labelText: "Enter topic name",
                  prefixIcon: Icon(Icons.topic_outlined),
                  border: InputBorder.none
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        spreadRadius:3,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                  color: Colors.white,                borderRadius: BorderRadius.circular(15)
              ),
              child: TextField(
                controller: date,
                decoration: InputDecoration(
                    labelText: "Enter date",
                    prefixIcon: Icon(Icons.date_range_outlined),
                    border: InputBorder.none
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 200,
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        spreadRadius:3,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: TextField(
                controller: note,
                maxLines: null, // <-- allows multiple lines
                expands: true,  // <-- makes text expand to fill the container height
                keyboardType: TextInputType.multiline, // <-- important for "enter" new line
                decoration: InputDecoration(
                    labelText: "Enter detains",
                    // prefixIcon: Icon(Icons.edit_calendar),
                    border: InputBorder.none
                ),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  shadowColor: Colors.black,
                  minimumSize: Size(100, 60)
                ),
                child: Text("Submit Notes",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),)
            )
          ],
        ),
      ),
    );
  }
}
