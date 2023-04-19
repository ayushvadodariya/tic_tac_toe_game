import 'package:flutter/material.dart';
import 'package:ox_game/pages/player_detail.dart';
import '../common/constants/values.dart';
import '../common/widgets/box_design.dart';
import '../common/widgets/button.dart';

class GameRoom extends StatefulWidget {
  String player1;
  String player2;
  GameRoom({required this.player1, required this.player2});

  @override
  State<GameRoom> createState() => _GameRoomState();
  @override
  initState(){
    Values.player1=player1 ;
    Values.player2=player2;
  }
}

class _GameRoomState extends State<GameRoom> {


  String circleImage = "assets/images/circle.png";
  String crossImage = "assets/images/cross.png";
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Values.bgColor,
      body: SafeArea(
        child:Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                        text:"Quit" ,
                        fontFamily: "SedgwickAveDisplay",
                        fontSize: 19,
                        textColor: Values.blackText,
                        buttonColor: Values.redButton,
                        onPressed:(){
                          setState(() {
                            Values.boxDetail = [
                              "0","0","0",
                              "0","0","0",
                              "0","0","0",
                            ];
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context)=> PlayerDetail()),
                          );
                        },
                      width: 80,
                      height: 50,
                    )
                  ],
                ),
              ),

              SizedBox(height: 150,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box(onTap: playerMove(0),boxNumber: 0,),
                  Box(onTap: playerMove(1),boxNumber: 1),
                  Box(onTap: playerMove(2),boxNumber: 2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box(onTap: playerMove(3),boxNumber: 3),
                  Box(onTap: playerMove(4),boxNumber: 4),
                  Box(onTap: playerMove(5),boxNumber: 5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box(onTap: playerMove(6),boxNumber: 6),
                  Box(onTap: playerMove(7),boxNumber: 7),
                  Box(onTap: playerMove(8),boxNumber: 8),
                ],
              ),
            ],
          ),
        ) ,
      )
    );
  }

   playerMove(int boxNumber){
    return Values.boxDetail[boxNumber]=="0" ? (){
      setState(() {
        if(Values.turn==widget.player1){
          Values.boxDetail[boxNumber]="assets/images/circle.png";
          winCondition(circleImage);
          Values.turn=widget.player2;
        }else{
          Values.boxDetail[boxNumber]="assets/images/cross.png";
          winCondition(crossImage);
          Values.turn=widget.player1;
        }
      });
    } :

    (){

    };
   }

    winCondition(String move){

    if( ( Values.boxDetail[0]==move && Values.boxDetail[1]==move && Values.boxDetail[2]==move ) ||
        ( Values.boxDetail[3]==move && Values.boxDetail[4]==move && Values.boxDetail[5]==move ) ||
        ( Values.boxDetail[6]==move && Values.boxDetail[7]==move && Values.boxDetail[8]==move ) ||
        ( Values.boxDetail[0]==move && Values.boxDetail[3]==move && Values.boxDetail[6]==move ) ||
        ( Values.boxDetail[1]==move && Values.boxDetail[4]==move && Values.boxDetail[5]==move ) ||
        ( Values.boxDetail[2]==move && Values.boxDetail[5]==move && Values.boxDetail[8]==move ) ||
        ( Values.boxDetail[0]==move && Values.boxDetail[4]==move && Values.boxDetail[8]==move ) ||
        ( Values.boxDetail[2]==move && Values.boxDetail[4]==move && Values.boxDetail[6]==move )
    ){

      AlertDialog dialog=AlertDialog(
        backgroundColor: Values.bgColor,
        title: Text("Winner!!",),
        content: Wrap(
          children: [
            Column(
              children: [
                Text(Values.turn,style: TextStyle(color: Colors.black),)
              ],
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Button(text: "Rematch", onPressed: (){}, buttonColor: Colors.blue, textColor: Values.blackText, width: 80,height: 50,),
              Button(text: "New Game", onPressed: (){}, buttonColor: Colors.green, textColor: Values.blackText,width: 80,height: 50,),
            ],
          )        ],

      );

      return showDialog(
          barrierDismissible: false,
          context: context, builder: (BuildContext context){
            return dialog;
      });
    }
   }

}


