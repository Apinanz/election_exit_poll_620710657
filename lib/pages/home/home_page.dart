import 'package:election_exit_poll_620710657/pages/election/election_list.dart';
import 'package:election_exit_poll_620710657/pages/election/election_result.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image(
                image: const AssetImage("assets/images/vote_hand.png"),
                width: 100,
                height: 100,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'เลือกตั้ง อบต.',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Text(
                  'รายชื่อผู้สมัครรับเลือกตั้ง',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  'นายกองค์การบริหารส่วนตำบลเขาพระ',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  'อำเภอเมืองนครนายก จังหวัดนครนายก',
                  style: Theme.of(context).textTheme.headline2,
                ),ElectionListPage(),
              ],
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, ElectionResultPage.routeName);
                },
                child: Text('ดูผล'))
          ],
        ),
      ),
    );
  }
}
