class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    
    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }
    
    // Check for at least one letter and one number
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على حروف وأرقام';
    }
    
    return null;
  }

  // Phone validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }
    
    // Remove spaces and special characters
    final cleanPhone = value.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Saudi phone number validation
    if (cleanPhone.startsWith('+966')) {
      if (cleanPhone.length != 13) {
        return 'رقم الهاتف غير صحيح';
      }
    } else if (cleanPhone.startsWith('966')) {
      if (cleanPhone.length != 12) {
        return 'رقم الهاتف غير صحيح';
      }
    } else if (cleanPhone.startsWith('05')) {
      if (cleanPhone.length != 10) {
        return 'رقم الهاتف غير صحيح';
      }
    } else {
      return 'رقم الهاتف غير صحيح';
    }
    
    return null;
  }

  // Name validation
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال الاسم';
    }
    
    if (value.length < 2) {
      return 'الاسم يجب أن يكون حرفين على الأقل';
    }
    
    if (value.length > 50) {
      return 'الاسم طويل جداً';
    }
    
    // Check for valid characters (Arabic, English, spaces)
    if (!RegExp(r'^[\u0600-\u06FFa-zA-Z\s]+$').hasMatch(value)) {
      return 'الاسم يحتوي على أحرف غير صحيحة';
    }
    
    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال $fieldName';
    }
    return null;
  }

  // Number validation
  static String? validateNumber(String? value, {double? min, double? max}) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم صحيح';
    }
    
    final number = double.tryParse(value);
    if (number == null) {
      return 'يرجى إدخال رقم صحيح';
    }
    
    if (min != null && number < min) {
      return 'القيمة يجب أن تكون $min أو أكثر';
    }
    
    if (max != null && number > max) {
      return 'القيمة يجب أن تكون $max أو أقل';
    }
    
    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    
    if (value != password) {
      return 'كلمة المرور غير متطابقة';
    }
    
    return null;
  }

  // License number validation (Saudi)
  static String? validateLicenseNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الرخصة';
    }
    
    // Saudi license format: 10 digits
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'رقم الرخصة يجب أن يكون 10 أرقام';
    }
    
    return null;
  }

  // National ID validation (Saudi)
  static String? validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهوية';
    }
    
    // Saudi national ID format: 10 digits starting with 1 or 2
    if (!RegExp(r'^[12]\d{9}$').hasMatch(value)) {
      return 'رقم الهوية غير صحيح';
    }
    
    return null;
  }

  // Commercial register validation
  static String? validateCommercialRegister(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم السجل التجاري';
    }
    
    // Saudi commercial register format: 10 digits starting with 1, 2, 3, 4, or 7
    if (!RegExp(r'^[12347]\d{9}$').hasMatch(value)) {
      return 'رقم السجل التجاري غير صحيح';
    }
    
    return null;
  }

  // Plate number validation (Saudi)
  static String? validatePlateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم اللوحة';
    }
    
    // Basic validation for now
    if (value.length < 3 || value.length > 10) {
      return 'رقم اللوحة غير صحيح';
    }
    
    return null;
  }

  // Insurance number validation
  static String? validateInsuranceNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم التأمين';
    }
    
    if (value.length < 5 || value.length > 20) {
      return 'رقم التأمين غير صحيح';
    }
    
    return null;
  }
}

