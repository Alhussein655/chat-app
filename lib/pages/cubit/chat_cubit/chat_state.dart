part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatSucces extends ChatState {
  List<MessageModel>messageList=[];
  ChatSucces({required this.messageList});
}
class ChatFailed extends ChatState {}
