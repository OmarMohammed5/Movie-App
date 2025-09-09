import 'package:flutter/material.dart';
import 'package:moviee_app/components/movie_search_view.dart';
import 'package:moviee_app/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: AppColors.kPrimaryColor,

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child:
                    /// display movie after searching immediately
                    MovieSearchView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
