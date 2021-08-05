import 'dart:ui';

import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const double cuyuyuHeaderHeight = 64;

// The font size delta for headline4 font.
const double desktopDisplay1FontDelta = 16;

// The width of the settingsDesktop.
const double desktopSettingsWidth = 520;

// Sentinel value for the system text scale factor option.
const double systemTextScaleFactorOption = -1;

// The splash page animation duration.
const splashPageAnimationDurationInMilliseconds = 300;

// The desktop top padding for a page's first header (e.g. Gallery, Settings)
const firstHeaderDesktopTopPadding = 5.0;

const baseURL = 'https://cuyuyu.firebaseio.com/';
const USER_URL = 'users';
const SHOP_URL = "Shop";
const PRODUCT = "Product";
const ORDERS = "Orders";
const CHAT = "Chat";
const CHAT_MESSAGES = "messages";
const BANNER_URL ="banners";
const PRODUCT_CATEGORY = "Category";
const SHOP_CATEGORY ="Shopcategory";

//Order fields
const ORDER_ID = "id";
const USER_ID = "userId";
const USER_NAME = "userName";
const USER_PHONE = "userPhone";
const USER_MAIL = "userEmail";
const USER_ADDRESS = "userAddress";
const ORDER_DETAIL = "orderDetail";
const FRETE = "frete";
const ORDER_ADRESS = "orderAddress";
const ORDER_DATE = "orderDate";
const PAYMENT = "orderPaymentMethod";
const STATUS = "orderStatus";
const COMMENT = "orderComment";
const SUBTOTAL = "subtotal";
const TOTAL = "total";
const LOCATION ="latlong";


//New version code
const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,);

const defaultDuration = Duration(milliseconds: 250);


class ShopAttributes{
  static const ID = "id";
  static const NAME = "name_shopping";
  static const LATITUDE = "latitude_shop";
  static const LOGITUDE = "longitude_shop";
  static const PHONE_NUMBER = "phone_number_shop";
  static const EMAIL = "email_shop";
  static const IMAGE = "image_url_shop";
  static const ADDRESS = "address_shop";
  static const OPEN_AT = "open_at_shop";
  static const CLOSE_AT = "close_at_shop";
  static const IS_OPEN = "is_open_shop";
  static const CATEGORY = "shop_category";
}

