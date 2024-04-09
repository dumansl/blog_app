import 'package:blog_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final bool isLastAdded;
  const CustomCard({super.key, this.isLastAdded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
      width: ScreenUtil.getWidth(context) * 0.5,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(16),
        image: isLastAdded
            ? const DecorationImage(
                image: AssetImage(
                  "assets/background_image.jpg",
                ),
                fit: BoxFit.cover)
            : null,
      ),
      child: Row(
        children: [
          if (!isLastAdded) ...[
            Container(
              margin: const EdgeInsets.only(right: 8),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/background_image.jpg",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: isLastAdded
                ? MainAxisAlignment.end
                : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Blog Title',
                style: TextStyle(
                  color: isLastAdded ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mattis, mauris vel tincidunt tempus, libero leo imperdiet ligula, a eleifend justo nibh molestie mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut posuere, tellus non dapibus mattis, nisl augue tempor lacus, non volutpat sem diam nec orci. Vivamus tempor volutpat lacus, vel pharetra leo vulputate quis.',
                style: TextStyle(
                  color: isLastAdded ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: ScreenUtil.getHeight(context) * 0.033,
                    width: ScreenUtil.getWidth(context) * 0.064,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Author Name',
                    style: TextStyle(
                      color: isLastAdded ? Colors.white : Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
