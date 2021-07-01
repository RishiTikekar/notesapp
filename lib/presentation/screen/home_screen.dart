import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/models/notes.dart';
import 'package:notesapp/core/theme/themedata.dart';
import 'package:notesapp/presentation/screen/add_note.dart';
import 'package:notesapp/presentation/screen/notes_details.dart';
import 'package:notesapp/presentation/widgets/time_function.dart';
import 'package:notesapp/providers/notes_provider.dart';

class HomeScreen extends StatelessWidget {
  NotesProvider _notesProvider = Get.find();

  List<Color> cardColors = [
    MyThemeData.BROWN_NOTES,
    MyThemeData.DARK_BROWN_NOTES,
    MyThemeData.GREEN_NOTES,
    MyThemeData.GREY_NOTES,
    MyThemeData.ORANGE_NOTES,
    MyThemeData.PEACH_NOTES,
    MyThemeData.PURPLE_NOTES
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        onPressed: () {
          Get.to(() => AddNote(
                currentNote: _notesProvider.blankNote,
                isEditing: false,
              ));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Notes',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<List<Notes>>(
              future: _notesProvider.getAllNotes(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Center(
                      child: Text("Sike!",
                          style: Theme.of(context).textTheme.headline1),
                    );
                  } else {
                    return grid(snapshot);
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
              },
            )),
      ),
    );
  }

  StaggeredGridView grid(AsyncSnapshot<List<Notes>> snapshot) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: (snapshot.data!.length),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () =>
              Get.to(() => NotesDetails(currentNote: snapshot.data![index])),
          child: Card(
            color: cardColors[(index % cardColors.length)],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.all(4),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    snapshot.data![index].title,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                  Divider(
                    height: 1,
                    color: MyThemeData.PRIMARY_BLACK_COLOR,
                  ),
                  Text(
                    snapshot.data![index].content,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    returnDate(snapshot.data![index].editTimeStamp),
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
