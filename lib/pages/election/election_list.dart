import 'package:election_exit_poll_620710657/models/election_item.dart';
import 'package:election_exit_poll_620710657/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElectionListPage extends StatefulWidget {
  const ElectionListPage({Key? key}) : super(key: key);

  @override
  _ElectionListPageState createState() => _ElectionListPageState();
}

class _ElectionListPageState extends State<ElectionListPage> {
  late Future<List<ElectionItem>> _futureElection;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<ElectionItem>>(
        future: _futureElection,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ผิดพลาด: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureElection = _loadElection();
                      });
                    },
                    child: Text('RETRY'),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var electionItem = snapshot.data![index];

                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: InkWell(
                    onTap: () => _handleClickCandidate(electionItem.number),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 50,height: 50,
                          color: Colors.green,
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              '${electionItem.number.toString()}',
                              style: GoogleFonts.prompt(fontSize: 20.0,color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${electionItem.toString()}',
                                      style: GoogleFonts.prompt(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<List<ElectionItem>> _loadElection() async {
    List list = await Api().fetch('exit_poll');
    var electionList = list.map((item) => ElectionItem.fromJson(item)).toList();
    return electionList;
  }

  @override
  initState() {
    super.initState();
    _futureElection = _loadElection();
  }

  _handleClickCandidate(int electionItem) {
    _election(electionItem);
  }

  Future<void> _election(int candidateNumber) async {
    var elector =
        (await Api().submit('exit_poll', {'candidateNumber': candidateNumber}));
    _showMaterialDialog('SUCCESS', 'บันทึกข้อมูลสำเร็จ ${elector.toString()}');
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
