
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonShimmer extends StatelessWidget {
  const SkeletonShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  borderRadius: BorderRadius.circular(35),
                  shape: BoxShape.rectangle,
                  width: size.width * 0.5,
                  height: size.height * 0.25),
            ),
          ),
          // SizedBox(height: 8),
          Expanded(
            child: SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 3,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    alignment: AlignmentDirectional.center,
                    randomLength: true,
                    height: 10,
                    borderRadius: BorderRadius.circular(8),
                    minLength: size.width / 6,
                    maxLength: size.width / 3,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
