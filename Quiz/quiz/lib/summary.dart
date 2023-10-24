import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary(this.summary_data, {super.key});
  final List<Map<String, Object>> summary_data;
  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summary_data.map((item) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    ((item['index'] as int) + 1).toString(),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        item['question'].toString(),
                        style: const TextStyle(
                          // color: Color.fromARGB(255, 187, 0, 244),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        item['selectedAnswer'].toString(),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 228, 253, 0),
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                      Text(
                        item['answer'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
