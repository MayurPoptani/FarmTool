import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/Global.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseController<T extends BaseDoc> {

  GlobalKey<FormState> formKey = GlobalKey();

  String? docId = "";

  uploadData(BuildContext context, {required List<MapEntry<IMAGESOURCE, String>?>? images}) async {
    if(formKey.currentState!.validate()==false) return;
    showProgressLoaderDialog(context);
    if(images!=null && images.where((element) => element!=null).isNotEmpty) uploadImages(context, prepareData(), images);
    else uploadDocument(context, prepareData());
  }

  T prepareData([List<String> imgUrls = const []]);

  uploadImages(BuildContext context, T doc, List<MapEntry<IMAGESOURCE, String>?> images) async {
    List<String> ls = [];
    List<MapEntry<IMAGESOURCE, String>?> temp = images.where((element) => element!=null).toList();
    String url;
    for(int i = 0 ; i < temp.length ; i++) {
      if(temp[i]!.key==IMAGESOURCE.PATH) {
        var task = await doc.folderReference.child(globalUser!.uid+"-"+DateTime.now().toIso8601String()+"."+temp[i]!.value.trim().split('/').last.split('.').last).putFile(File(temp[i]!.value));
        url = await task.ref.getDownloadURL();
      } else {
        url = temp[i]!.value;
      }  
      print("url = "+url);
      ls.add(url);
    }
    uploadDocument(context, prepareData(ls));
  }

  uploadDocument(BuildContext context, T doc, [List<String>? imgUrls]) async {
    
    if(doc.id!="") {
      await doc.firebaseDocRef.update(doc.toMap());
    } else {
      DocumentReference docRef = await doc.firebaseColRef.add(doc.toMap());
      print(docRef.id);
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop(true);
  }

  showProgressLoaderDialog(BuildContext context, [bool isExisting = false]) {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (_) => AlertDialog(
        title: Text(isExisting ? "Updating..." : "Uploading..."),
        content: Container(
          height: 100,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.green),
          ),
        ),
      ),
    );
  }

  Future<void> deletePost(CollectionReference colRef, String docId) async {
    try {
      await colRef.doc(docId).delete();
      return Future.value();
    } on PlatformException catch (e) {
      return Future.error(e, StackTrace.fromString(e.stacktrace??""));
    }
  }
}