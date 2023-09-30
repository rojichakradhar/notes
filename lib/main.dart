import 'package:flutter/material.dart';
import 'package:note/notes_model.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottomsheet(),
    );
  }
}

List<NoteSchema> noteSchema = [];
TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();

class Bottomsheet extends StatefulWidget {
  const Bottomsheet({Key? key}) : super(key: key);

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 231, 223, 152),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () {
          sheet(context);
          //Container(child: Column(children: [],))
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: ListView.separated(
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: false,
          itemCount: noteSchema.length,
          itemBuilder: (context, index) => Schema(
            title: noteSchema[index].title,
            content: noteSchema[index].content,
            date: noteSchema[index].date,
            index: index,
            ontap: () {
              sheet(context, index: index);
            },
          ),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> sheet(BuildContext context, {int index = -1}) {
    if (index != -1) {
      NoteSchema selectedNote = noteSchema[index];
      titleController.text = selectedNote.title;
      contentController.text = selectedNote.content;

      noteSchema[index] = selectedNote.copyWith(
          date: DateFormat('yyyy-MM-dd,HH:mm').format(DateTime.now()));
    } else {
      titleController.clear();
      contentController.clear();
    }
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      if (index != -1) {
                        final selectedNote = noteSchema[index];
                        selectedNote.title = titleController.text;
                        selectedNote.content = contentController.text;
                      } else {
                        noteSchema.add(NoteSchema(
                          title: titleController.text,
                          content: contentController.text,
                          date: DateFormat('yyyy-MM-dd,HH:mm')
                              .format(DateTime.now()),
                          index: (''),
                        ));
                      }
                    });
                    Navigator.pop(context);
                  },

                  //backgroundColor: Colors.amber,
                ),
                //Text(DateFormat('yyyy-MM-dd,HH:mm').format(DateTime.now())),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: contentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Schema extends StatefulWidget {
  const Schema(
      {Key? key,
      required this.title,
      required this.content,
      required this.index,
      required this.date,
      required this.ontap})
      : super(key: key);
  final String title;
  final void Function()? ontap;
  final String content;
  final int index;
  final String date;
  @override
  State<Schema> createState() => _SchemaState();
}

class _SchemaState extends State<Schema> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      // () => widget.sheet(context, index: widget.index),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 232, 209, 139)),
          color: const Color.fromARGB(255, 240, 236, 201),
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.content,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              maxLines: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.date.toString()),
          ],
        ),
      ),
    );
  }
}
