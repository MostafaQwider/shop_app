import 'package:get/get.dart';

import 'strings.dart';

/// User roles in the application
enum UserRole { rider, driver, admin }

/// Ride status
enum RideStatus { requested, accepted, inProgress, completed, cancelled }

/// Vehicle types
enum VehicleType { car, bike, van, bus, scooter }

/// Payment methods (حتى لو ما في دفع، ممكن تضيفها للمستقبل)
enum PaymentMethod { cash, card, wallet }

/// Rating types
enum RatingType { riderToDriver, driverToRider }

/// Online status for drivers
enum DriverStatus { online, offline, busy }

/// Request status (API)
enum StatusRequest {
  initial,
  loading,
  success,
  nodata,
  failure,
  offline,
  serverError,
  exception,
}

extension StatusRequestExtension on StatusRequest {
  String get message {
    switch (this) {
      case StatusRequest.offline:
        return AppStrings.internetConnectionError.tr;
      case StatusRequest.failure:
      case StatusRequest.serverError:
      case StatusRequest.exception:
        return AppStrings.serverError.tr;
      case StatusRequest.nodata:
        return AppStrings.noData.tr;
      default:
        return "";
    }
  }
}

/// Extension methods for enums
extension EnumExtensions on Enum {
  /// Converts enum to readable string
  String get displayName {
    switch (this) {
    // 🧭 User Roles
      case UserRole.rider:
        return 'Rider';
      case UserRole.driver:
        return 'Driver';
      case UserRole.admin:
        return 'Admin';

    // 🧭 Ride Status
      case RideStatus.requested:
        return 'Requested';
      case RideStatus.accepted:
        return 'Accepted';
      case RideStatus.inProgress:
        return 'In Progress';
      case RideStatus.completed:
        return 'Completed';
      case RideStatus.cancelled:
        return 'Cancelled';

    // 🧭 Vehicle Types
      case VehicleType.car:
        return 'Car';
      case VehicleType.bike:
        return 'Bike';
      case VehicleType.van:
        return 'Van';
      case VehicleType.bus:
        return 'Bus';
      case VehicleType.scooter:
        return 'Scooter';

    // 🧭 Payment
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.wallet:
        return 'Wallet';

    // 🧭 Rating
      case RatingType.riderToDriver:
        return 'Rider to Driver';
      case RatingType.driverToRider:
        return 'Driver to Rider';

    // 🧭 Driver Status
      case DriverStatus.online:
        return 'Online';
      case DriverStatus.offline:
        return 'Offline';
      case DriverStatus.busy:
        return 'Busy';

    // 🧭 StatusRequest
      case StatusRequest.initial:
        return 'Initial';
      case StatusRequest.loading:
        return 'Loading';
      case StatusRequest.success:
        return 'Success';
      case StatusRequest.nodata:
        return 'No Data';
      case StatusRequest.failure:
        return 'Failure';
      case StatusRequest.offline:
        return 'Offline';
      case StatusRequest.serverError:
        return 'Server Error';
      case StatusRequest.exception:
        return 'Exception';

      default:
        return name;
    }
  }
}

/// Helper class for enum operations
class EnumUtils {
  /// Parses string to enum value
  static T? fromString<T extends Enum>(List<T> values, String value) {
    try {
      return values
          .firstWhere((e) => e.name.toLowerCase() == value.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  /// Converts enum to string (for JSON)
  static String toJson<T extends Enum>(T value) => value.name;

  /// Converts string to enum (from JSON)
  static T fromJson<T extends Enum>(List<T> values, String value) =>
      values.firstWhere((e) => e.name == value);
}
