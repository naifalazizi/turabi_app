import 'package:flutter/material.dart';
import '../../../shared/widgets/app_scaffold.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'حجز جديد',
      showBackButton: true,
      body: Center(
        child: Text('شاشة الحجز - قيد التطوير'),
      ),
    );
  }
}

