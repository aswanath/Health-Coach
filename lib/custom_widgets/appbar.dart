import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppBarTitle extends StatelessWidget {
  final String? title;
  final String? author;
  const AppBarTitle({
     this.title,
     this.author,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title!=null)...[Text(title!,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: 17.sp)),],
        if(author!=null)...[
          Text(
          author!,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(height: .8),
        ),],
      ],
    );
  }
}