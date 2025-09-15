import 'package:flutter/material.dart';
import 'package:notes/notebytext.dart';
import 'package:notes/speech_to_text.dart';
import 'package:notes/note_model.dart';

import 'Show_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late PageController _pageController;
  List<NoteModel> notes = []; // shared notes

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.cyanAccent,
      title: Text("Home Screen"),
      actions: [
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotesListScreen(notes: notes),
              ),
            );
          },

        )
      ],
    ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.tealAccent),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/myimage.jpg"),
                    radius: 40,
                  ),
                  Text("Abhishek raj sharma"),
                  Text("maninewtan9682@gmail.com"),
                ],
              ),
            ),
            ListTile(leading: Icon(Icons.details_outlined), title: Text("About us")),
            ListTile(leading: Icon(Icons.history), title: Text("History")),
            ListTile(leading: Icon(Icons.help), title: Text("Help")),
            ListTile(leading: Icon(Icons.contact_phone_outlined), title: Text("Contact")),
            ListTile(leading: Icon(Icons.location_searching_outlined), title: Text("Location")),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() => index = 0);
                  _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
                child: Container(
                  width: 120,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index == 0 ? Colors.deepOrangeAccent : Colors.grey,
                  ),
                  child: Center(
                    child: Text("Voice", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() => index = 1);
                  _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
                child: Container(
                  width: 120,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index == 1 ? Colors.deepOrangeAccent : Colors.grey,
                  ),
                  child: Center(
                    child: Text("Text", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              children: [
                Note(notes: notes,),
                By_text(notes: notes),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
