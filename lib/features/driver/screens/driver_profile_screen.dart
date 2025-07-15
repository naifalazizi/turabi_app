import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../providers/driver_provider.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'الملف الشخصي - السائق',
      showBackButton: true,
      body: Consumer2<AuthProvider, DriverProvider>(
        builder: (context, authProvider, driverProvider, child) {
          final user = authProvider.currentUser;
          
          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Text(
                          user?.name.substring(0, 1) ?? 'س',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'السائق',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user?.email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            driverProvider.isAvailable 
                                ? Icons.check_circle 
                                : Icons.cancel,
                            color: driverProvider.isAvailable 
                                ? AppColors.success 
                                : AppColors.error,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            driverProvider.isAvailable ? 'متاح للعمل' : 'غير متاح',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: driverProvider.isAvailable 
                                  ? AppColors.success 
                                  : AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (user?.rating != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColors.ratingGold,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${user!.rating!.toStringAsFixed(1)} (${user.totalRatings} تقييم)',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Driver Specific Info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'معلومات السائق',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (user?.licenseNumber != null) ...[
                        _buildInfoRow(
                          context,
                          icon: Icons.card_membership,
                          label: 'رقم الرخصة',
                          value: user!.licenseNumber!,
                        ),
                        const SizedBox(height: 12),
                      ],
                      if (user?.nationalId != null) ...[
                        _buildInfoRow(
                          context,
                          icon: Icons.perm_identity,
                          label: 'الهوية الوطنية',
                          value: user!.nationalId!,
                        ),
                        const SizedBox(height: 12),
                      ],
                      _buildInfoRow(
                        context,
                        icon: Icons.phone,
                        label: 'رقم الهاتف',
                        value: user?.phone ?? '',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Trucks Section
                if (user?.trucks != null && user!.trucks!.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'شاحناتي',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...user.trucks!.map((truck) {
                          return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
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
                                  Icon(
                                    Icons.local_shipping,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    truck.model ?? 'غير محدد',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'رقم اللوحة: ${truck.plateNumber}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'الحمولة: ${truck.capacity} كجم',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                
                // Menu Items
                _buildMenuItem(
                  context,
                  icon: Icons.edit_outlined,
                  title: 'تعديل الملف الشخصي',
                  onTap: () {
                    // TODO: Navigate to edit driver profile
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.local_shipping_outlined,
                  title: 'إدارة الشاحنات',
                  onTap: () {
                    // TODO: Navigate to truck management
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.history,
                  title: 'سجل الرحلات',
                  onTap: () {
                    // TODO: Navigate to trip history
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'الأرباح والمدفوعات',
                  onTap: () {
                    // TODO: Navigate to earnings
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'الإشعارات',
                  onTap: () {
                    // TODO: Navigate to notifications settings
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'المساعدة والدعم',
                  onTap: () {
                    // TODO: Navigate to help
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'حول التطبيق',
                  onTap: () {
                    // TODO: Show about dialog
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.logout,
                  title: 'تسجيل الخروج',
                  onTap: () async {
                    await authProvider.logout();
                    if (context.mounted) {
                      context.go('/user-type');
                    }
                  },
                  isDestructive: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.textSecondary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? AppColors.error : AppColors.textSecondary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDestructive ? AppColors.error : AppColors.textPrimary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textHint,
        ),
        onTap: onTap,
      ),
    );
  }
}
