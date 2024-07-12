import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/model/history_detail.dart';

class itemHistoryDetail extends StatelessWidget {
  itemHistoryDetail({
    super.key,
    required this.historyDetail,
  });
  HistoryDetail historyDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(historyDetail.imageUrl),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 200,
                        child: Text(
                          historyDetail.productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    const Text("Size: 41.5")
                  ],
                ),
              ],
            ),
            Text("${historyDetail.price} \$")
          ],
        ),
      ),
    );
  }
}
