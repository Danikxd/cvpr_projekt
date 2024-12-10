import 'package:cvpr_projekt/pages/create_book/create_book_page.dart';
import 'package:cvpr_projekt/pages/home_page/book_search.dart';
import 'package:cvpr_projekt/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
  initialLocation: '/',
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomePage()),
    GoRoute(path: "/search", builder: (context, state) => const BookSearch()),
    GoRoute(path: "/create", builder: (context, state) => const CreateBookPage()),
  ],
);