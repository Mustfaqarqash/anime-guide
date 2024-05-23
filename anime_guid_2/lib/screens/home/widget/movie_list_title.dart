import 'package:flutter/material.dart';

class MovieListTitle extends StatelessWidget {
  final String title;
  const MovieListTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    //  ThemeData theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                // color: Colors.white,
              ),
            ),
            const Spacer(),
            // const Text(
            //   '  See all >',
            //   style: TextStyle(
            //     //  color: Colors.white,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
