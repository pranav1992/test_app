import 'dart:math';

import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin{

  int val1 =0;
  int val2 = 0;
  double degree = 0;
  // late double angle = degree*pi/45;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync:this,duration: const Duration(milliseconds:500));
    setRotation(0);

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }



  void setRotation(int degrees){
    final angle = degrees*pi/45;
    animation = Tween<double>(begin: 0,end: angle).animate(controller);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Test App'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      maxLines: 6,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter Something',labelStyle: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)
                      ),
                      onChanged: (val) =>
                      setState(() {
                        val1 = val.replaceAll(' ', '').length;
                        if(val1 == val2){
                          setRotation(0);
                          controller.forward(from: degree);
                          degree =0;
                        }else if(val1 > val2){
                          setRotation(-10);
                          controller.forward(from: degree);
                          degree = -10;
                        }else{
                          setRotation(10);
                          controller.forward(from: degree);
                          degree = 10;
                        }
                      })
                      ,
                    ),
                  ),
                ),
                const Expanded(flex: 1,child:VerticalDivider(),),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      maxLines: 6,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter Something',labelStyle: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)
                      ),
                      onChanged: (val) =>
                          setState(() {
                            val2 = va2.replaceAll(' ', '').length;
                            if(val1 == val2){
                              setRotation(0);
                              controller.forward(from: degree);
                              degree = 0;
                            }else if(val2>val1){
                              setRotation(10);
                              controller.forward(from: degree);
                              degree = 10;
                            }else{
                              setRotation(-10);
                              controller.forward(from: degree);
                              degree = -10;
                            }
                          })
                      ,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
              child: AnimatedBuilder(
                animation: animation,
                child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(duration:Duration.zero,color:Colors.blue,child:


                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Text(val1 == 0 ?'':'$val1',style: const TextStyle(fontSize:24,backgroundColor: Colors.white),),
                        )),

                        Container(color: Colors.blue,width: 120,height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: AnimatedContainer(duration:Duration.zero,color:Colors.blue,child: Text(val2 == 0?'':'$val2',style: const TextStyle(fontSize:24,backgroundColor: Colors.white),)),
                        ),

                      ],
                    )),
                builder: (context,child) => Transform.rotate(
                  angle: animation.value,
                  child: child
                ),
              ),

          ),

        ],

      ),

    );
  }
}
