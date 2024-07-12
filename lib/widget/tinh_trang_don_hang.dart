import 'package:flutter/material.dart';

class tinhtrangdonhang extends StatelessWidget {
  const tinhtrangdonhang({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12);
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.green[200],
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Đơn hàng đã được giao", style: textStyle),
              Text(
                "Cảm ơn bạn đã tin tưởng và đặt hàng của chúng tôi!",
                style: textStyle.copyWith(fontWeight: FontWeight.normal),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )
        ],
      ),
    );
  }
}
