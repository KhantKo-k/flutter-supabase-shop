// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'IShop';

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
  String get createAcc => 'Create Account';

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
  String get hello => 'Hello';

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
  String get save => 'Save';

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

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get order => 'Order';

  @override
  String get orderSlip => 'Order Pay Slip';

  @override
  String get orderId => 'Order ID';

  @override
  String get pending => 'PENDING';

  @override
  String get deliveryAddress => 'DELIVERY ADDRESS';

  @override
  String get items => 'ITEMS';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get free => 'Free';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get delete => 'Delete';

  @override
  String get cancelDelete => 'Cancel';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get deleteMessage =>
      'Are you sure you want to delete this order? This cannot be undone.';

  @override
  String get deleteProfile =>
      'Are you sure you want to delete this profile? This cannot be undone.';

  @override
  String get productDetail => 'Product Details';

  @override
  String get updateCart => 'Update to Cart';

  @override
  String get toCheckOut => 'Proceed to Checkout';

  @override
  String get checkOut => 'Check Out';

  @override
  String get contactDetail => 'Contact Details';

  @override
  String get receiverName => 'Receiver Name';

  @override
  String get receiverPhone => 'Receiver Phone';

  @override
  String get selectCity => 'Select City';

  @override
  String get selectStreet => 'Select Street';

  @override
  String get houseNo => 'House/Apartment No.';

  @override
  String get optional => 'Optional';

  @override
  String get additionalNote => 'Additional Note';

  @override
  String get payment => 'Payment';

  @override
  String get pay => 'Pay';

  @override
  String get required => 'Required';

  @override
  String get phoneNumberError => 'Enter a valid number';

  @override
  String get phoneNUmberEmpty => 'Enter your phone number';

  @override
  String get houseNoError => 'Enter house number';

  @override
  String get orderSuccess => 'Order placed successfully!';

  @override
  String get errorFields => 'Please complete all address fields';

  @override
  String get nameError => 'Please enter your name';

  @override
  String get emailError => 'Please enter your email';

  @override
  String get passwordError => 'Please enter your password';

  @override
  String get emailValidation => 'Please enter a valid email';

  @override
  String get passwordValidation => 'Password must be exactly 8 numbers';

  @override
  String get welcomeText =>
      'Welcome to our shopping app. We make your \n shopping experiences ease and convient';

  @override
  String get greetingText => 'Good to see you back!';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String get logoutText => 'Are you sure you want to log out?';
}
