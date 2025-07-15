import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String bookingId;
  
  const BookingDetailsScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الحجز'),
      ),
      body: Center(
        child: Text('تفاصيل الحجز: $bookingId'),
      ),
    );
  }
}

