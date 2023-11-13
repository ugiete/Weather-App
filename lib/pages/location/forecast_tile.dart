import 'package:flutter/material.dart';

class ForecastTile extends StatelessWidget {
  final String day;
  final IconData icon;
  final int min;
  final int max;

  const ForecastTile({super.key, required this.day, required this.icon, required this.min, required this.max});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(
        day,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      title: Icon(icon, color: Colors.white),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$minº',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20.0),
                backgroundColor: Colors.indigo.shade300,
                value: 0,
              )
            ),
          ),
          Text(
            '$maxº',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
        ],
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text(
    //       day,
    //       style: const TextStyle(
    //         color: Colors.white,
    //         fontSize: 16,
    //         fontWeight: FontWeight.bold
    //       ),
    //     ),
    //     Container(
    //       width: 60,
    //       color: Colors.red,
    //       child: Center(child: )
    //     ),
    //     Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text(
    //           '$minº',
    //           style: TextStyle(
    //             color: Colors.grey.shade400,
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold
    //           )
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //           child: SizedBox(
    //             width: 100,
    //             child: LinearProgressIndicator(
    //               borderRadius: BorderRadius.circular(20.0),
    //               backgroundColor: Colors.indigo.shade300,
    //               value: 0,
    //             )
    //           ),
    //         ),
    //         Text(
    //           '$maxº',
    //           style: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold
    //           )
    //         ),
    //       ],
    //     ),
    //   ]
    // );
  }
}