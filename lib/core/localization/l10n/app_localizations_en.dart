// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ShopEasy';

  @override
  String get home => 'Home';

  @override
  String get categories => 'Categories';

  @override
  String get cart => 'Cart';

  @override
  String get profile => 'Profile';

  @override
  String get wishlist => 'Wishlist';

  @override
  String get letsStart => 'Let\'s get started!';

  @override
  String get alreadyAcc => 'Already have an account?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get cancel => 'Cancel';

  @override
  String get typePassword => 'Type your password';

  @override
  String get done => 'Done';

  @override
  String get createAcc => 'Create \nAccount';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get searchProducts => 'Search products...';

  @override
  String get featuredProducts => 'Featured Products';

  @override
  String get topCategories => 'Top Categories';

  @override
  String get specialOffers => 'Special Offers';

  @override
  String get viewAll => 'View All';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get buyNow => 'Buy Now';

  @override
  String get inStock => 'In Stock';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String reviews(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Reviews',
      one: '1 Review',
      zero: 'No Reviews',
    );
    return '$_temp0';
  }

  @override
  String itemsLeft(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items left',
      one: '1 item left',
      zero: 'Out of stock',
    );
    return '$_temp0';
  }

  @override
  String get yourCart => 'Your Cart';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get startShopping => 'Start Shopping';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get shipping => 'Shipping';

  @override
  String get tax => 'Tax';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get remove => 'Remove';

  @override
  String get shippingAddress => 'Shipping Address';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get placeOrder => 'Place Order';

  @override
  String get myOrders => 'My Orders';

  @override
  String get settings => 'Settings';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get logout => 'Logout';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign Up';

  @override
  String addedToCart(Object product) {
    return '$product added to cart';
  }

  @override
  String removedFromCart(Object product) {
    return '$product removed from cart';
  }

  @override
  String get addedToWishlist => 'Added to wishlist';

  @override
  String get orderPlaced => 'Order placed successfully!';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get success => 'Success';

  @override
  String get saved => 'Saved';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(Object count) {
    return '$count minutes ago';
  }

  @override
  String hoursAgo(Object count) {
    return '$count hours ago';
  }

  @override
  String daysAgo(Object count) {
    return '$count days ago';
  }
}
