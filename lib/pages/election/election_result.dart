import 'package:election_exit_poll_620710657/models/election_result.dart';
import 'package:election_exit_poll_620710657/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElectionResultPage extends StatefulWidget {
  static const routeName = '/result';
  const ElectionResultPage({Key? key}) : super(key: key);


  @override
  _ElectionResultPageState createState() => _ElectionResultPageState();
}

class _ElectionResultPageState extends State<ElectionResultPage> {
  late Future<List<ElectionResult>> _futureElection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
              image: const AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: const AssetImage("assets/images/vote_hand.png"),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            Text(
              'RESULT',
              style: Theme.of(context).textTheme.headline1,
            ),
            FutureBuilder<List<ElectionResult>>(
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${electionItem.score}',style: GoogleFonts.prompt(fontSize: 16.0)),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
  Future<List<ElectionResult>> _loadElection() async {
    List list = await Api().fetch('exit_poll/result');
    var electionList = list.map((item) => ElectionResult.fromJson(item)).toList();
    return electionList;
  }

  @override
  initState() {
    super.initState();
    _futureElection = _loadElection();
  }
}
