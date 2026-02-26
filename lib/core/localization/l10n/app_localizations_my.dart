// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appName => 'အိုင်ရှော့ပ်';

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
  String get cancel => 'ဖျက်မည်';

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
  String get subtotal => 'အောက်ခံတန်ဖိုး';

  @override
  String get shipping => 'Shipping';

  @override
  String get tax => 'Tax';

  @override
  String get total => 'စုစုပေါင်း';

  @override
  String get checkout => 'ငွေပေးချေမည်';

  @override
  String get remove => 'Remove';

  @override
  String get shippingAddress => 'Shipping Address';

  @override
  String get paymentMethod => 'ငွေပေးချေမှုနည်းလမ်း';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get placeOrder => 'Place Order';

  @override
  String get myOrders => 'ကျွန်ုပ်၏အော်ဒါများ';

  @override
  String get settings => 'Settings';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get logout => 'ပြန်ထွက်ရန်';

  @override
  String get login => 'အကောင့်ဝင်မည်';

  @override
  String get signup => 'Sign Up';

  @override
  String get hello => 'မင်္ဂလာပါ';

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
  String get save => 'သိမ်းမည်';

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
  String get editProfile => 'ပရိုဖိုင်ပြင်ရန်';

  @override
  String get order => 'အော်ဒါ';

  @override
  String get orderSlip => 'ငွေပေးချေမှုအချုပ်အနှစ်';

  @override
  String get orderId => 'အော်ဒါ နံပါတ်';

  @override
  String get pending => 'ဆောင်ရွက်ဆဲ';

  @override
  String get deliveryAddress => 'ပို့ဆောင်ရန်လိပ်စာ';

  @override
  String get items => 'ပစ္စည်းများ';

  @override
  String get deliveryFee => 'ပို့ဆောင်ခ';

  @override
  String get free => 'အခမဲ့';

  @override
  String get totalAmount => 'စုစုပေါင်းတန်ဖိုး';

  @override
  String get delete => 'ဖျက်မည်';

  @override
  String get cancelDelete => 'မဖျက်တော့ပါ';

  @override
  String get confirmDelete => 'ဖျက်ရန်အတည်ပြုပါ';

  @override
  String get deleteMessage =>
      'ဤအော်ဒါကိုဖျက်ရန်သေချာပါသလား။ ၎င်းကိုပြန်လည်ရယူ၍မရနိုင်ပါ။';

  @override
  String get deleteProfile => 'ဒီပရိုဖိုင်ကိုဖျက်မှာသေချာလား။';

  @override
  String get productDetail => 'ကုန်ပစ္စည်းအသေးစိတ်';

  @override
  String get updateCart => 'ဈေးခြင်းထဲသို့ပြင်ဆင်သိမ်းမည်';

  @override
  String get toCheckOut => 'ငွေပေးချေရန် ဆက်လုပ်မည်';

  @override
  String get checkOut => 'ငွေပေးချေရန်';

  @override
  String get contactDetail => 'ဆက်သွယ်ရန်အချက်အလက်';

  @override
  String get receiverName => 'လက်ခံသူအမည်';

  @override
  String get receiverPhone => 'လက်ခံသူဖုန်းနံပါတ်';

  @override
  String get selectCity => 'မြို့/မြို့နယ်ရွေးချယ်ပါ';

  @override
  String get selectStreet => 'လမ်းရွေးချယ်ပါ';

  @override
  String get houseNo => 'အိမ်အမှတ်/တိုက်ခန်းအမှတ်';

  @override
  String get optional => 'ထည့်ရန်မလိုအပ်';

  @override
  String get additionalNote => 'အထူးမှာကြားချက်';

  @override
  String get payment => 'ငွေပေးချေမှု';

  @override
  String get pay => 'ငွေပေးချေမည်';

  @override
  String get required => 'လိုအပ်သည်';

  @override
  String get phoneNumberError => 'ဖုန်းနံပါတ်မှန်ကန်စွာထည့်ပါ';

  @override
  String get phoneNUmberEmpty => 'သင့်ဖုန်းနံပါတ်ထည့်ပါ';

  @override
  String get houseNoError => 'အိမ်အမှတ်ထည့်ပါ';

  @override
  String get orderSuccess => 'အော်ဒါအောင်မြင်စွာတင်ခဲ့သည်။';

  @override
  String get errorFields => 'လိပ်စာအကွက်အားလုံးဖြည့်စွက်ပေးပါ';

  @override
  String get nameError => 'သင့်နာမည်ထည့်ပေးပါ';

  @override
  String get emailError => 'သင့်အီးမေးလ်လိပ်စာထည့်ပေးပါ';

  @override
  String get passwordError => 'လျှို့ဝှက်နံပါတ်ထည့်ပေးပါ';

  @override
  String get emailValidation => 'မှန်ကန်သောအီးမေးလ်လိပ်စာကိုထည့်ပါ';

  @override
  String get passwordValidation => 'စကားဝှက်သည် ဂဏန်း ၈ လုံးအတိအကျဖြစ်ရပါမည်';

  @override
  String get welcomeText =>
      'ကျွန်ုပ်တို့၏ဈေးဝယ်အက်ပ်သို့ ကြိုဆိုပါသည်။ သင်၏ဈေးဝယ်အတွေ့အကြုံကို လွယ်ကူအဆင်ပြေစေရန် ကျွန်ုပ်တို့ဖန်တီးပေးထားပါသည်။';

  @override
  String get greetingText => 'ပြန်တွေ့ရတာ ဝမ်းသာပါတယ်။';

  @override
  String get confirmLogout => 'အကောင့်မှထွက်ရန်အတည်ပြုပါ';

  @override
  String get logoutText => 'အကောင့်မှထွက်ရန်သေချာပါသလား။';
}
