class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String userType; // 'customer' or 'driver'
  final String? profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isVerified;
  final bool isActive;
  final double? rating;
  final int? totalRatings;
  
  // Customer specific fields
  final String? companyName;
  final String? commercialRegister;
  
  // Driver specific fields
  final String? licenseNumber;
  final String? nationalId;
  final List<TruckModel>? trucks;
  
  // Location and distance fields
  final LocationModel? currentLocation;
  double? distance; // المسافة من المستخدم الحالي (متغيرة)

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    this.isVerified = false,
    this.isActive = true,
    this.rating,
    this.totalRatings,
    this.companyName,
    this.commercialRegister,
    this.licenseNumber,
    this.nationalId,
    this.trucks,
    this.currentLocation,
    this.distance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      userType: json['user_type'] ?? 'customer',
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      isVerified: json['is_verified'] ?? false,
      isActive: json['is_active'] ?? true,
      rating: json['rating']?.toDouble(),
      totalRatings: json['total_ratings'],
      companyName: json['company_name'],
      commercialRegister: json['commercial_register'],
      licenseNumber: json['license_number'],
      nationalId: json['national_id'],
      trucks: json['trucks'] != null 
          ? (json['trucks'] as List).map((truck) => TruckModel.fromJson(truck)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'user_type': userType,
      'profile_image': profileImage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_verified': isVerified,
      'is_active': isActive,
      'rating': rating,
      'total_ratings': totalRatings,
      'company_name': companyName,
      'commercial_register': commercialRegister,
      'license_number': licenseNumber,
      'national_id': nationalId,
      'trucks': trucks?.map((truck) => truck.toJson()).toList(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? userType,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isVerified,
    bool? isActive,
    double? rating,
    int? totalRatings,
    String? companyName,
    String? commercialRegister,
    String? licenseNumber,
    String? nationalId,
    List<TruckModel>? trucks,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userType: userType ?? this.userType,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      companyName: companyName ?? this.companyName,
      commercialRegister: commercialRegister ?? this.commercialRegister,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      nationalId: nationalId ?? this.nationalId,
      trucks: trucks ?? this.trucks,
    );
  }
}

class TruckModel {
  final String id;
  final String type;
  final String brand;
  final String model;
  final int year;
  final String plateNumber;
  final double capacity;
  final String? image;
  final bool isAvailable;
  final String? insuranceNumber;
  final DateTime? insuranceExpiry;

  TruckModel({
    required this.id,
    required this.type,
    required this.brand,
    required this.model,
    required this.year,
    required this.plateNumber,
    required this.capacity,
    this.image,
    this.isAvailable = true,
    this.insuranceNumber,
    this.insuranceExpiry,
  });

  factory TruckModel.fromJson(Map<String, dynamic> json) {
    return TruckModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      year: json['year'] ?? 0,
      plateNumber: json['plate_number'] ?? '',
      capacity: json['capacity']?.toDouble() ?? 0.0,
      image: json['image'],
      isAvailable: json['is_available'] ?? true,
      insuranceNumber: json['insurance_number'],
      insuranceExpiry: json['insurance_expiry'] != null 
          ? DateTime.parse(json['insurance_expiry'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'brand': brand,
      'model': model,
      'year': year,
      'plate_number': plateNumber,
      'capacity': capacity,
      'image': image,
      'is_available': isAvailable,
      'insurance_number': insuranceNumber,
      'insurance_expiry': insuranceExpiry?.toIso8601String(),
    };
  }
}

// Location Model
class LocationModel {
  final double latitude;
  final double longitude;
  final String? address;
  final String? city;
  final String? district;

  LocationModel({
    required this.latitude,
    required this.longitude,
    this.address,
    this.city,
    this.district,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      address: json['address'],
      city: json['city'],
      district: json['district'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'district': district,
    };
  }
}

