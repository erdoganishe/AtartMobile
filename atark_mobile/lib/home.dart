import 'package:chess_arina/api/lock_request.dart';
import 'package:flutter/material.dart';
import 'addOrRemoveKey.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0AAFF),
      appBar: AppBar(
        title: Text('Your locks'),
        backgroundColor: const Color(0xff7B2CBF),
      ),
      body: Center(
          child: FutureBuilder<List<LockDetails>>(
              future: getLockDetailsByUId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return ListView.separated(
                    itemBuilder: (BuildContext context, int i) {
                      final excersiceData = snapshot.data as List<LockDetails>;
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xffE0AAFF),
                            backgroundColor: const Color(0xff3C096C),
                            padding: EdgeInsets.all(15),
                          ),
                          child: Text(
                            "${excersiceData[i].name}",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPage(
                                    idString: "${excersiceData[i].id}",
                                    nameString: "${excersiceData[i].name}",
                                    isAbleToChange:
                                        excersiceData[i].isAbleToChange),
                              ),
                            );
                            setState(() {
                              print(
                                  "ISATCH: ${excersiceData[i].isAbleToChange}");
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: snapshot.data!.length);
              })
          // ListView.builder(
          //   itemCount: locks.length,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           foregroundColor: const Color(0xffE0AAFF),
          //           backgroundColor: const Color(0xff3C096C),
          //           padding: EdgeInsets.all(15),
          //         ),
          //         child: Text(
          //           locks[index],
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         onPressed: () {

          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => NewPage(
          //                 inputString: locks[index],
          //                 number: index,
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     );
          //   },
          // ),
          ),
    );
  }
}
