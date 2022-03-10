import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: NinjaCard(),
  ));
}

class NinjaCard extends StatefulWidget {
  const NinjaCard({Key? key}) : super(key: key);

  @override
  State<NinjaCard> createState() => _NinjaCardState();
}


class _NinjaCardState extends State<NinjaCard> {

  int characterLevel = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text('Character ID'),
        centerTitle: true,
        backgroundColor: Colors.purple[900],
        elevation: 0.0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            characterLevel += 1;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[800],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('asset/thumbnail.jpg'),
                radius: 50.0,
              ),
            ),

            Divider(
              height: 40.0,
              color: Colors.grey[900],
            ),

            Text('NAME', style: TextStyle(color: Colors.white, letterSpacing: 2.0,), ),
            SizedBox(height: 10.0),
            Text('Yae Miko', style: TextStyle(color: Colors.purple[800], letterSpacing: 2.0, fontSize: 28.0, fontWeight: FontWeight.bold,), ),

            SizedBox(height: 30.0),

            Text('LEVEL', style: TextStyle(color: Colors.white, letterSpacing: 2.0,), ),
            SizedBox(height: 10.0),
            Text('$characterLevel', style: TextStyle(color: Colors.purple[800], letterSpacing: 2.0, fontSize: 28.0, fontWeight: FontWeight.bold,), ),

            SizedBox(height: 30.0),

            Row(
              children: <Widget>[
                Icon(Icons.email, color: Colors.grey,),

                SizedBox(width: 5.0),

                Text('not_yae_sakura@internet.of.things', style: TextStyle(color: Colors.cyan, fontSize: 16.0, letterSpacing: 1.0,), ),
              ],
            )

          ],
        ),
      ),

    );
  }
}
