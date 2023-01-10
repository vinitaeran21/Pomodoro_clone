import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f6),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f6),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.dehaze_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Text(
                'SUMMARY',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              height: 250,
              child: LayoutBuilder(
                builder: (BuildContext context, constraints) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.08,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: 56,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f6),
                              borderRadius: BorderRadius.circular(4)),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '1 hour \n1 min',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.04,
                        ),
                        Text(
                          'Focused Time',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.08,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: 64,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f6),
                              borderRadius: BorderRadius.circular(4)),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '1 session',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.04,
                        ),
                        Text(
                          'Fininsed',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Divider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.08,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: 56,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f6),
                              borderRadius: BorderRadius.circular(4)),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '1 hour \n1 min',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.04,
                        ),
                        Text(
                          'Focused Time',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.08,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: 64,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f6),
                              borderRadius: BorderRadius.circular(4)),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '1 session',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.04,
                        ),
                        Text(
                          'Fininsed',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.08,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: 56,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f6),
                              borderRadius: BorderRadius.circular(4)),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '1 hour \n1 min',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.04,
                        ),
                        Text(
                          'Focused Time',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.08,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: 64,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f6),
                              borderRadius: BorderRadius.circular(4)),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '1 session',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.04,
                        ),
                        Text(
                          'Fininsed',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
