import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  static String id = 'chat screen';
  ScrollController scrollController = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var uId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Image.asset(
              kLogo,
              height: 30,
              color: Colors.white,
            ),
            Text('Chat')
          ]),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemBuilder: (context, index) =>
                      messagesList[index].id == uId
                          ? ChatBuble(
                              message: messagesList[index],
                            )
                          : ChatBubleAnother(message: messagesList[index]),
                  scrollDirection: Axis.vertical,
                  itemCount: messagesList.length,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        BlocProvider.of<ChatCubit>(context).sendMessage(
                            msg: controller.text, uId:uId);

                        controller.clear();
                        scrollController.animateTo(0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      },
                      icon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      )),
                  hintText: 'Enter your message'),
            ),
          )
        ]));
  }
}
