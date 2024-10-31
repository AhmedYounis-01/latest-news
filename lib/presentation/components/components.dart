import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_todo_app/presentation/screens/web_view_screen.dart';

Widget buildArticleItems(Map<String, dynamic> article, BuildContext context) {
  String imageUrl = article['urlToImage'] ?? '';

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: article['url']),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsetsDirectional.all(12),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            height: 130,
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/not_found.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/not_found.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    article['title'] ?? 'No Title',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    article['publishedAt'] ?? 'No Date',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget articleBuilder(List<dynamic> list, BuildContext context,
    {bool isSearch = false}) {
  return ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItems(list[index], context),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: list.length,
    ),
    fallback: (context) => isSearch
        ? const Center(
            child: Text(
              'No results found',
            ),
          )
        : const Center(child: CircularProgressIndicator()),
  );
}
