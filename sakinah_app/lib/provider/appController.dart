// ignore_for_file: file_names, library_prefixes
import 'package:get/get.dart';

class AppController extends GetxController {
  var isDark = false.obs;
  var enabledBiometric = false.obs;
  var selectedTabIndex = 1.obs;
  var selectedTabIndex1 = 0.obs;
  var theme = false.obs;
  var registerLoader = false.obs;
  var registerWithImportLoader = false.obs;
  var loginLoader = false.obs;
  var userWalletsLoader = false.obs;
  var getBalanceLoader = false.obs;
  var getNetworksLoader = false.obs;
  var getAllCoinsLoader = false.obs;
  var getTransactionsLoader = false.obs;
  var sendAmountLoader = false.obs;
  var getContactsLoader = false.obs;
  var importTokenLoader = false.obs;
  var changePassLoader = false.obs;
  var createNewWalletLoader = false.obs;
  var importWalletLoader = false.obs;

  var password = ''.obs;

  var getSwapTransactionsLoader = false.obs;
  var swapLoader = false.obs;
  var seeAll = false.obs;
  var hideBalance = false.obs;
  var selectedIndex = 0.obs;
  var selectedBOttomTabIndex = 0.obs;
  var updateProfileLoader = false.obs;
  var withdrawFiatLoader = false.obs;
  var withdrawCryptoLoader = false.obs;
  var swapCryptoLoader = false.obs;
  var verifyEmailLoader = false.obs;
  var getLoggedInUserLoader = false.obs;
  var getSwapQuoteLoader = false.obs;
  var verifyOtpLoader = false.obs;
  var forgotPassLoader = false.obs;
  var resetPassLoader = false.obs;
  var currenciesLoader = false.obs;
  var getFeeLoader = false.obs;

  var selectCurrenciesList = <String>[].obs;
  var userBalanceInNaira = ''.obs;
  var deleteProfileLoader = false.obs;

  var selectCoinIndex = 0.obs;
  var shoudApiCallsRun = false.obs;
  var errMsg = ''.obs;
  var shouldCallDashboardApi = true.obs;

  
}