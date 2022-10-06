import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.name,
    required this.description,
    required this.day,
  });
  final String name;
  final int day;
  // final String monthNum;
  // final String monthString;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
      child: SizedBox(
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 33,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        const Expanded(
                            flex: 25,
                            child: Center(
                              child: Text(
                                'Mon',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            )),
                        Expanded(
                            flex: 25,
                            child: Center(
                                child: Text(
                              '$day',
                              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                            ))),
                        const Expanded(
                            flex: 25,
                            child: Center(
                                child: Text(
                              'May',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                            ))),
                      ],
                    ),
                  )),
              Expanded(
                flex: 66,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Text(
                          name,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(description),
                      ),
                    ),
                    Row(
                      children: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
