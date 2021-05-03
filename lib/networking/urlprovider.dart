import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

class UrlProvider {
  static final String DOMAIN_LOCAL_DEBUG = "http://192.168.1.201/labashopping";
  static final String DOMAIN_DEBUG = "http://thelabashopping.com";
  static final String DOMAIN_RELEASE = "http://thelabashopping.com";

  static final String DOMAIN_IMAGE_LOCAL_DEBUG = "http://thelabashopping.com";

  static final String DOMAIN_IMAGE_DEBUG = "http://thelabashopping.com";

  static final String DOMAIN_IMAGE_RELEASE = "http://thelabashopping.com";

  static final String REGISTER = "/api/public/registerUser";
  static final String AUTHENTICATE_USER = "/api/public/login";
  static final String VERIFY_OTP = "/api/public/verifyMobile";
  static final String GET_CITY = "/api/public/getCity";
  static final String GET_CATEGORY = "/api/public/getCategories";
  static final String GET_PRODUCT_HOME = "/api/public/getProductsOnHome";
  static final String GET_BANNERS = "/api/public/getBanners";

  static final String GET_BRANDS = "/api/public/getBrands";
  static final String GET_PRODUCTS_BY_BRANDS = "/api/public/getProductsByBrand";
  static final String GET_PRODUCTS_BY_CAT = "/api/public/getProductsByCategory";
  static final String ADD_PRODUCT_TO_CART = "/api/public/addToCart";
  static final String GET_CART = "/api/public/getCart";
  static final String ADD_PRODUCT_TO_WISHLIST =
      "/api/public/addProductToWishlist";
  static final String GET_WISHLIST = "/api/public/getWishlist";

  static final String GET_EVENTS = "/api/public/getEvents";
  static final String GET_TODAYS_DEAL = "/api/public/getTodaysDeal";
  static final String VERIFY_VENDOR = "/api/public/verifyVendor";
  static final String CONFIRM_BOOKING = "/api/public/confirmBooking";
  static final String GET_BOOKING_LIST = "/api/public/getBookingList";
  static final String DELETE_CART = "/api/public/deleteCartItem";
  static final String GET_BOOTHS = "/api/public/getBooths";
  static final String VOTE_BOOTH = "/api/public/postVote";
  static final String GET_KEYWORDS = "/api/public/getKeywords";
  static final String GET_PRODUCTS_BY_KEYWORDS =
      "/api/public/getProductsByKeywords";
  static final String GET_NOTIFICATION = "/api/public/getNotifications";
  static final String UPDATE_EMAIL = "/api/public/updateEmail";
  static final String UPDATE_ACCOUNT = "/api/public/updateAccount";
  static final String UPDATE_ADDRESS = "/api/public/updateAddress";
  static final String UPDATE_PASSWORD = "/api/public/changePassword";
  static final String UPDATE_MEMBER_PIC = "/api/public/updateMemberPic";
  static final String UPDATE_MOBILE = "/api/public/updateMobile";
  static final String FORGOT_PASSWORD = "/api/public/forgotPassword";
  static final String MARK_ATT = "/api/public/markAttendance";
  static final String UPDATE_FCM_TOKEN = "/api/public/updateFcmToken";

  static final String GET_ADDRESS = "/api/public/getAddress";
  static final String ADD_ADDRESS = "/api/public/addAddress";
  static final String DELETE_ADDRESS = "/api/public/deleteAddress";
  static final String CREATE_ORDER = "/api/public/createOrder";

  static final String GET_ORDERS = "/api/public/getOrders";

  static final String GET_ORDER_ID = "/api/public/getOrderId";
  static final String CANCEL_ORDER = "/api/public/cancelOrder";

  static String getDomain() => DOMAIN_RELEASE;
  static String getSessionId() => AppSharedPrefs.getSyncAuthToken();

  static String getMarkAttUrl() {
    return getDomain() + MARK_ATT;
  }

  //TODO GET AUTH TOKEN FROM DB
  static String getAuthToken() => AppSharedPrefs.getSyncAuthToken();

  static String getAuthenticateUserUrl() {
    return getDomain() + AUTHENTICATE_USER;
  }

  static String getRegisterUrl() {
    return getDomain() + REGISTER;
  }

  static String createOrderUrl() {
    return getDomain() + CREATE_ORDER;
  }

  static String getCityUrl() {
    return getDomain() + GET_CITY;
  }

  static String getKeywordsUrl() {
    return getDomain() + GET_KEYWORDS;
  }

  static String getVerifyOTPUrl() {
    return getDomain() + VERIFY_OTP;
  }

  static String getCategoryListUrl() {
    return getDomain() + GET_CATEGORY + "/" + getCountry();
  }

  static String getProductListHomeUrl(int pageSize, int pageNo) {
    return getDomain() +
        GET_PRODUCT_HOME +
        "/" +
        getCountry() +
        "/" +
        getSessionId() +
        "/" +
        pageSize.toString() +
        "/" +
        pageNo.toString();
  }

  static String getBannerListUrl() {
    return getDomain() + GET_BANNERS + "/" + getCountry();
  }

  static String getOrdersUrl() {
    return getDomain() + GET_ORDERS + "/" + getAuthToken();
  }

  static String getOrderDetailsUrl(String orderId) {
    return getDomain() + GET_ORDERS + "/" + getAuthToken() + "/" + orderId;
  }

  static String getAddToCartUrl() {
    return getDomain() + ADD_PRODUCT_TO_CART;
  }

  static String getAddToWishListUrl() {
    return getDomain() + ADD_PRODUCT_TO_WISHLIST;
  }

  static String getBrandsUrl() {
    return getDomain() + GET_BRANDS + "/" + getAuthToken();
  }

  static String getProductsByBrandUrl(String brandId) {
    return getDomain() +
        GET_PRODUCTS_BY_BRANDS +
        "/" +
        getAuthToken() +
        "/" +
        brandId;
  }

  static String orderIdUrl(String amount) {
    return getDomain() + GET_ORDER_ID + "/" + getAuthToken() + "/" + amount;
  }

  static String getProductsByKeywordsUrl(String keyword) {
    return getDomain() +
        GET_PRODUCTS_BY_KEYWORDS +
        "/" +
        getSessionId() +
        "/" /*URLEncoder.encode(keyword)*/; //TODO do stuffs
  }

  static String getProductsByCatUrl(
      {String catId, String subCatId, String pageSize, String pageNo}) {
    return getDomain() +
        GET_PRODUCTS_BY_CAT +
        "/" +
        catId +
        "/" +
        subCatId +
        "/" +
        getSessionId() +
        "/" +
        pageSize +
        "/" +
        pageNo;
  }

  static String getCartUrl() {
    return getDomain() + GET_CART + "/" + getSessionId();
  }

  static String getAddressUrl() {
    return getDomain() + GET_ADDRESS + "/" + getAuthToken();
  }

  static String addAddressUrl() {
    return getDomain() + ADD_ADDRESS;
  }

  static String getNotificationUrl() {
    return getDomain() + GET_NOTIFICATION + "/" + getAuthToken();
  }

  static String getWishListUrl() {
    return getDomain() + GET_WISHLIST + "/" + getAuthToken();
  }

  static String getBoothListUrl() {
    return getDomain() + GET_BOOTHS + "/" + getAuthToken();
  }

  static String getConfirmBookingUrl() {
    return getDomain() + CONFIRM_BOOKING;
  }

  static String getVerifyVendorUrl() {
    return getDomain() + VERIFY_VENDOR;
  }

  static String voteForBoothUrl() {
    return getDomain() + VOTE_BOOTH;
  }

  static String getEventsUrl() {
    return getDomain() + GET_EVENTS + "/" + getAuthToken();
  }

  static String getTodaysDealUrl() {
    return getDomain() + GET_TODAYS_DEAL + "/" + getAuthToken();
  }

  static String getBokkingListUrl() {
    return getDomain() + GET_BOOKING_LIST + "/" + getAuthToken();
  }

  static String getDeleteCartUrl() {
    return getDomain() + DELETE_CART;
  }

  static String getUpdateEmailUrl() {
    return getDomain() + UPDATE_EMAIL;
  }

  static String getUpdateAccountUrl() {
    return getDomain() + UPDATE_ACCOUNT;
  }

  static String getUpdateAddressUrl() {
    return getDomain() + UPDATE_ADDRESS;
  }

  static String getUpdateFcmTokenUrl() {
    return getDomain() + UPDATE_FCM_TOKEN;
  }

  static String getUpdatePasswordUrl() {
    return getDomain() + UPDATE_PASSWORD;
  }

  static String getUpdateMemberPicUrl() {
    return getDomain() + UPDATE_MEMBER_PIC;
  }

  static String getUpdateMobileUrl() {
    return getDomain() + UPDATE_MOBILE;
  }

  static String getForgotPasswordUrl() {
    return getDomain() + FORGOT_PASSWORD;
  }

  static String getCancelOrderUrl() {
    return getDomain() + CANCEL_ORDER;
  }

  static String getCountry() => 'IND';

  static String getInitInstamojoReqUrl() =>
      'https://test.instamojo.com/api/1.1/payment-requests/';
}
