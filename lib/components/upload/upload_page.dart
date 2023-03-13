import 'package:flutter/material.dart';

import 'package:uploadtofirebase/components/upload/dropped_file.dart';
import 'package:uploadtofirebase/components/upload/dropzone_widget.dart';

import '../../cloud/cloud_objects.dart';
import '../../responsive/side_menu.dart';
import '../../service/firebase_service.dart';
import '../constants/app_bar.dart';
import '../constants/background.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  bool insideTarget = false;
  DroppedFile? file;
  FirestoreService _firestoreService = FirestoreService();

  final latController = TextEditingController();
  final lngController = TextEditingController();
  final locController = TextEditingController();
  final titleController = TextEditingController();
  final infoController = TextEditingController();
  final speciesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: myBackgroundColor,
      drawer: const SideMenu(),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Center(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildImage(),
                            if (file != null) buildFileDetails(file!),
                          ],
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 200,
                          width: 800,
                          child: DropzoneWidget(
                            onDroppedFile: (file) =>
                                setState(() => this.file = file),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 800,
                    width: 600,
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      buildTextFieldUp("Latitude", latController),
                      buildTextFieldUp("Longitude", lngController),
                      buildTextFieldUp("Location", locController),
                      buildTextFieldUp("Title", titleController),
                      buildTextFieldUp("Information", infoController),
                      buildTextFieldUp("Species", speciesController),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('object');
                              saveMarker();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                side: const BorderSide(
                                    width: 1, color: Colors.grey)),
                            onPressed: () {
                              setState(() {
                                //latController.clear();
                                //lngController.clear();
                                //locController.clear();
                                //titleController.clear();
                                //infoController.clear();
                                //speciesController.clear();
                                MarkerUpdate datastore = MarkerUpdate(
                                    id: "0",
                                    strID: "0",
                                    username: "Current User",
                                    usericon: "Users_icon",
                                    image: "waiting_file",
                                    lat: 0.0,
                                    lng: 0.0,
                                    zoom: 10,
                                    loc: "No Entry",
                                    species: "Needs Class",
                                    date: [
                                      DateTime.now().day.toString(),
                                      DateTime.now().month.toString(),
                                      DateTime.now().year.toString()
                                    ],
                                    time: "N/A",
                                    title: "N/A",
                                    info: "N/A",
                                    site: "N/A",
                                    color: "white",
                                    hide: true,
                                    temp: 25,
                                    updatesLis: "",
                                    dataEntries: [],
                                    logs: []);
                              });
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ]),
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    latController.dispose();
    lngController.dispose();
    locController.dispose();
    titleController.dispose();
    infoController.dispose();
    speciesController.dispose();
    super.dispose();
  }

  Future<void> saveMarker() async {
    if (latController.text != "" && lngController.text != "" && file != null) {
      await _firestoreService.uploadImage(file!);

      MarkerUpdate datastore = MarkerUpdate(
          id: "",
          strID: "0",
          username: "Username",
          usericon: "User Icon",
          image:
              'https://source.unsplash.com/random/?${speciesController.text}', //file!.name will replace when image can be sent over
          lat: double.parse(latController.text),
          lng: double.parse(lngController.text),
          zoom: 10,
          loc: locController.text.toString(),
          species: speciesController.text.toString(),
          date: [
            DateTime.now().day.toString(),
            DateTime.now().month.toString(),
            DateTime.now().year.toString()
          ],
          time: DateTime.now().toString(),
          title: titleController.text.toString(),
          info: infoController.text.toString(),
          site: "observation",
          color: "white",
          hide: true,
          temp: 25,
          updatesLis: "", //This is where I can add the data for
          dataEntries: [],
          logs: []);

      await _firestoreService.saveMarker(datastore);
    } else {
      print('Provide input Details');
    }
  }

  Widget buildImage() {
    if (file == null) return buildEmptyFile('No File');

    return Image.network(
      file!.url,
      width: 360,
      height: 360,
      fit: BoxFit.cover,
      errorBuilder: (context, error, _) => buildEmptyFile('No Preview'),
    );
  }

  Widget buildFileDetails(DroppedFile file) {
    const style = TextStyle(color: Colors.white, fontSize: 20);

    return Container(
      margin: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(file.name, style: style),
          const SizedBox(height: 8),
          Text(file.size, style: style)
        ],
      ),
    );
  }

  Widget buildEmptyFile(String text) {
    return Container(
      width: 240,
      height: 240,
      color: const Color.fromARGB(255, 0, 174, 255),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  upload() {
    try {
      latController.clear();
      lngController.clear();
      locController.clear();
      titleController.clear();
      infoController.clear();
      speciesController.clear();
    } catch (e) {
      print(e);
    }
  }

  Widget buildTextFieldUp(
      String labelText, TextEditingController fieldController) {
    return SizedBox(
      height: 100,
      width: 600,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: TextField(
          controller: fieldController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: const TextStyle(
                color: Colors.grey, fontSize: 20, letterSpacing: 2.2),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400]),
        ),
      ),
    );
  }
}
