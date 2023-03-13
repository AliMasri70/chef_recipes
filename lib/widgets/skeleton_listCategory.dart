import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonListCategory extends StatelessWidget {
  const SkeletonListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(35),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 2,
                    spacing: 5,
                    lineStyle: SkeletonLineStyle(
                      alignment: AlignmentDirectional.center,
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: size.width / 1.6,
                      maxLength: size.width / 1.5,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.1,
          )
        ],
      ),
    );
  }
}
