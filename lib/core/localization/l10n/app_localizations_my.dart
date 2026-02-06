// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appName => 'ရှော့အဆင်';

  @override
  String get home => 'ပင်မစာမျက်နှာ';

  @override
  String get categories => 'အမျိုးအစားများ';

  @override
  String get cart => 'ဈေးခြင်းတောင်း';

  @override
  String get profile => 'ကိုယ်ရေးအချက်အလက်';

  @override
  String get wishlist => 'အကြိုက်စာရင်း';

  @override
  String get letsStart => 'စတင်လိုက်ကြရအောင်';

  @override
  String get alreadyAcc => 'အကောင့်ရှိပြီးသားလား?';

  @override
  String get email => 'အီးမေးလ်လိပ်စာ';

  @override
  String get password => 'လျှို့ဝှက်နံပါတ်';

  @override
  String get name => 'အမည်';

  @override
  String get cancel => 'ထွက်မည်';

  @override
  String get typePassword => 'လျှို့ဝှက်နံပါတ်ရိုက်ထည့်ပါ';

  @override
  String get done => 'ပြီးပါပြီ';

  @override
  String get createAcc => 'အကောင့်အသစ်ဖွင့်ရန်';

  @override
  String get phoneNumber => 'ဖုန်းနံပါတ်';

  @override
  String get searchProducts => 'ကုန်ပစ္စည်းများရှာဖွေရန်...';

  @override
  String get featuredProducts => 'ထင်ရှားသောကုန်ပစ္စည်းများ';

  @override
  String get topCategories => 'Top Categories';

  @override
  String get specialOffers => 'Special Offers';

  @override
  String get viewAll => 'View All';

  @override
  String get addToCart => 'ဈေးခြင်းတောင်းထဲသို့ထည့်မည်';

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
  String get yourCart => 'သင့်ဈေးခြင်းတောင်း';

  @override
  String get emptyCart => 'ဈေးခြင်းတောင်းထဲတွင်ဘာမှမရှိပါ';

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
  String get checkout => 'ငွေပေးချေမည်';

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
  String get login => 'အကောင့်ဝင်မည်';

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
