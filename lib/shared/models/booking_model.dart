import 'user_model.dart';

class BookingModel {
  final String id;
  final String customerId;
  final String? driverId;
  final String materialType;
  final double quantity;
  final String unit; // 'cubic_meter', 'ton', 'trip'
  final LocationModel pickupLocation;
  final LocationModel deliveryLocation;
  final DateTime scheduledDate;
  final String status;
  final double? estimatedPrice;
  final double? finalPrice;
  final String paymentMethod;
  final String? paymentStatus;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel? customer;
  final UserModel? driver;
  final TruckModel? truck;
  final List<String>? images;
  final RatingModel? rating;

  BookingModel({
    required this.id,
    required this.customerId,
    this.driverId,
    required this.materialType,
    required this.quantity,
    required this.unit,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.scheduledDate,
    required this.status,
    this.estimatedPrice,
    this.finalPrice,
    required this.paymentMethod,
    this.paymentStatus,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.customer,
    this.driver,
    this.truck,
    this.images,
    this.rating,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      customerId: json['customer_id'] ?? '',
      driverId: json['driver_id'],
      materialType: json['material_type'] ?? '',
      quantity: json['quantity']?.toDouble() ?? 0.0,
      unit: json['unit'] ?? 'cubic_meter',
      pickupLocation: LocationModel.fromJson(json['pickup_location'] ?? {}),
      deliveryLocation: LocationModel.fromJson(json['delivery_location'] ?? {}),
      scheduledDate: DateTime.parse(json['scheduled_date'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'pending',
      estimatedPrice: json['estimated_price']?.toDouble(),
      finalPrice: json['final_price']?.toDouble(),
      paymentMethod: json['payment_method'] ?? 'cash',
      paymentStatus: json['payment_status'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      customer: json['customer'] != null ? UserModel.fromJson(json['customer']) : null,
      driver: json['driver'] != null ? UserModel.fromJson(json['driver']) : null,
      truck: json['truck'] != null ? TruckModel.fromJson(json['truck']) : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      rating: json['rating'] != null ? RatingModel.fromJson(json['rating']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'driver_id': driverId,
      'material_type': materialType,
      'quantity': quantity,
      'unit': unit,
      'pickup_location': pickupLocation.toJson(),
      'delivery_location': deliveryLocation.toJson(),
      'scheduled_date': scheduledDate.toIso8601String(),
      'status': status,
      'estimated_price': estimatedPrice,
      'final_price': finalPrice,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'customer': customer?.toJson(),
      'driver': driver?.toJson(),
      'truck': truck?.toJson(),
      'images': images,
      'rating': rating?.toJson(),
    };
  }

  BookingModel copyWith({
    String? id,
    String? customerId,
    String? driverId,
    String? materialType,
    double? quantity,
    String? unit,
    LocationModel? pickupLocation,
    LocationModel? deliveryLocation,
    DateTime? scheduledDate,
    String? status,
    double? estimatedPrice,
    double? finalPrice,
    String? paymentMethod,
    String? paymentStatus,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? customer,
    UserModel? driver,
    TruckModel? truck,
    List<String>? images,
    RatingModel? rating,
  }) {
    return BookingModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      driverId: driverId ?? this.driverId,
      materialType: materialType ?? this.materialType,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      status: status ?? this.status,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      customer: customer ?? this.customer,
      driver: driver ?? this.driver,
      truck: truck ?? this.truck,
      images: images ?? this.images,
      rating: rating ?? this.rating,
    );
  }
}



class RatingModel {
  final String id;
  final String bookingId;
  final String raterId;
  final String ratedId;
  final double rating;
  final String? comment;
  final DateTime createdAt;

  RatingModel({
    required this.id,
    required this.bookingId,
    required this.raterId,
    required this.ratedId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'] ?? '',
      bookingId: json['booking_id'] ?? '',
      raterId: json['rater_id'] ?? '',
      ratedId: json['rated_id'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_id': bookingId,
      'rater_id': raterId,
      'rated_id': ratedId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

