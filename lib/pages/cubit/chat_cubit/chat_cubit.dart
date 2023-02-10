import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<MessageModel>messageList=[];
  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollection);
  void sendMessage({required String msg,required String uId}){
    MessageModel message=MessageModel(msg, uId);
    messages.add(message.toJson());
  }
 void getMessage(){
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      messageList.clear();
      for(var doc in event.docs){
     messageList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSucces(messageList: messageList));
    });
  }
}
