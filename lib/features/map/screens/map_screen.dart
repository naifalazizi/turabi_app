import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../providers/map_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  geolocator.Position? _currentPosition;
  
  // الرياض كموقع افتراضي
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.7136, 46.6753), // الرياض
    zoom: 12.0,
  );

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    await _checkLocationPermissions();
    await _getCurrentLocation();
  }

  Future<void> _checkLocationPermissions() async {
    bool serviceEnabled;
    geolocator.LocationPermission permission;

    // تحقق من تشغيل خدمة الموقع
    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى تشغيل خدمة الموقع'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission == geolocator.LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم رفض إذن الوصول للموقع'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('إذن الوصول للموقع مرفوض نهائياً. يرجى تفعيله من الإعدادات'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });

      if (_controller != null) {
        _controller!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude),
          ),
        );
      }
    } catch (e) {
      debugPrint('خطأ في الحصول على الموقع: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'الخريطة',
      showBackButton: true,
      body: Consumer<MapProvider>(
        builder: (context, mapProvider, child) {
          return Stack(
            children: [
              // الخريطة
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  if (_currentPosition != null) {
                    controller.animateCamera(
                      CameraUpdate.newLatLng(
                        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                      ),
                    );
                  }
                },
                initialCameraPosition: _initialPosition,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: _buildMarkers(mapProvider),
                onTap: (LatLng position) {
                  // يمكن إضافة وظائف عند النقر على الخريطة
                  mapProvider.setSelectedLocation(position);
                },
              ),

              // شريط البحث
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'ابحث عن موقع...',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                    ),
                    onSubmitted: (value) {
                      // البحث عن موقع
                      mapProvider.searchLocation(value);
                    },
                  ),
                ),
              ),

              // زر الموقع الحالي
              Positioned(
                bottom: 100,
                right: 16,
                child: FloatingActionButton(
                  heroTag: "map_location_fab",
                  onPressed: _getCurrentLocation,
                  backgroundColor: AppColors.primary,
                  child: const Icon(
                    Icons.my_location,
                    color: AppColors.white,
                  ),
                ),
              ),

              // قائمة السائقين المتاحين
              if (mapProvider.availableDrivers.isNotEmpty)
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'السائقون المتاحون',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mapProvider.availableDrivers.length,
                            itemBuilder: (context, index) {
                              final driver = mapProvider.availableDrivers[index];
                              return Container(
                                width: 150,
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.greyLight,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: AppColors.primary.withOpacity(0.1),
                                          child: Text(
                                            driver.name.substring(0, 1),
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                driver.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: AppColors.ratingGold,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    driver.rating?.toStringAsFixed(1) ?? '0.0',
                                                    style: const TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'المسافة: ${(driver.distance ?? 0).toStringAsFixed(1)} كم',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    ElevatedButton(
                                      onPressed: () {
                                        mapProvider.selectDriver(driver);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(double.infinity, 32),
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                      ),
                                      child: const Text(
                                        'اختيار',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Set<Marker> _buildMarkers(MapProvider mapProvider) {
    Set<Marker> markers = {};

    // موقع المستخدم الحالي
    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: const InfoWindow(
            title: 'موقعك الحالي',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    // مواقع السائقين المتاحين
    for (var driver in mapProvider.availableDrivers) {
      if (driver.currentLocation != null) {
        markers.add(
          Marker(
            markerId: MarkerId('driver_${driver.id}'),
            position: LatLng(
              driver.currentLocation!.latitude,
              driver.currentLocation!.longitude,
            ),
            infoWindow: InfoWindow(
              title: driver.name,
              snippet: 'التقييم: ${driver.rating?.toStringAsFixed(1) ?? 'غير محدد'}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            onTap: () {
              mapProvider.selectDriver(driver);
            },
          ),
        );
      }
    }

    // الموقع المحدد للحجز
    if (mapProvider.selectedLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: mapProvider.selectedLocation!,
          infoWindow: const InfoWindow(
            title: 'الموقع المحدد',
            snippet: 'اسحب لتعديل الموقع',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          draggable: true,
          onDragEnd: (LatLng position) {
            mapProvider.setSelectedLocation(position);
          },
        ),
      );
    }

    return markers;
  }
}
