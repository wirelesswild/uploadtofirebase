import 'dart:html';
import 'dart:typed_data';

import 'package:firebase/firebase.dart';

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

import '../cloud/cloud_objects.dart';
import '../components/upload/dropped_file.dart';

class FirestoreService {
  String markerCollection = 'markers';
  String imageUrl = '';
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  uploadImage(DroppedFile file) async {
    String? mimeType = mime(basename(file.name));
    var metaData = UploadMetadata(contentType: mimeType);
    StorageReference storageReference =
        storage().ref('WebImage').child(file.name);

    UploadTask uploadTask = storageReference.put(file.data, metaData);

    uploadTask.future.then((snapshot) => {
          Future.delayed(Duration(seconds: 1)).then((value) => {
                snapshot.ref.getDownloadURL().then((dynamic uri) {
                  imageUrl = uri.toString();

                  print('Download URL: ${imageUrl.toString()}');
                })
              })
        });
  }

  Future<void> saveMarker(mark) async {
    try {
      final docMark =
          FirebaseFirestore.instance.collection(markerCollection).doc();

      final upMark = MarkerUpdate(
          id: docMark.id,
          strID: docMark.id,
          username: "Username",
          usericon: "User Icon",
          image: imageUrl,
          lat: mark.lat,
          lng: mark.lng,
          zoom: mark.zoom,
          loc: mark.loc,
          species: mark.species,
          date: mark.date,
          time: mark.time,
          title: mark.title,
          info: mark.info,
          site: mark.site,
          color: "white",
          hide: mark.hide,
          temp: mark.temp,
          updatesLis: mark.updatesLis,
          dataEntries: mark.dataEntries,
          logs: mark.logs);

      final json = upMark.toJson();

      await docMark.set(json);
    } catch (e) {
      print(e);
    }
  }
}
