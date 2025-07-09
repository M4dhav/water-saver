import 'package:cloud_firestore/cloud_firestore.dart';

class FBCollections {
  static final CollectionReference userProfile =
      FirebaseFirestore.instance.collection('user_profile');
  static final CollectionReference userDataReceive =
      FirebaseFirestore.instance.collection('user_data_receive');
  static final CollectionReference userDataUpload =
      FirebaseFirestore.instance.collection('user_data_upload');
}
