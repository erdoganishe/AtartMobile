import 'package:chess_arina/api/lock_request.dart';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  final String idString;
  final String nameString;
  bool isAbleToChange;

  NewPage(
      {required this.idString,
      required this.nameString,
      required this.isAbleToChange});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0AAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xff7B2CBF),
        title: Text('Change lock for ${widget.nameString}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/add.png'),
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          putLock(widget.idString, !widget.isAbleToChange);
                          setState(() {
                            widget.isAbleToChange = !widget.isAbleToChange;
                          });
                        },
                        child: Text(
                          widget.isAbleToChange ? 'Lock lock' : "Unlock lock",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xffE0AAFF),
                          backgroundColor: const Color(0xff3C096C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
