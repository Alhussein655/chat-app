import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageModel {
  final String message;
   String id;
  MessageModel(this.message, this.id);

  factory MessageModel.fromJson(json) {
    return MessageModel(json[kMessage], json['id']);
  }
 Map<String, dynamic> toJson() {
    var auth= FirebaseAuth.instance;
    id=auth.currentUser!.uid;
    return {'message': message, 'id': id, 'createdAt': DateTime.now()};
  }
}
