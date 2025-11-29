class FeatureFlags {
  final bool wishlistEnabled;
  final bool enablePaypal;
  final bool ordermanagmentEnabled;
  final bool searchEnabled;
  final bool flashSale;

  const FeatureFlags({
    required this.wishlistEnabled,
    required this.enablePaypal,
    required this.ordermanagmentEnabled,
    required this.searchEnabled,
    required this.flashSale,
  });

  static const empty = FeatureFlags(
    wishlistEnabled: false,
    enablePaypal: false,
    ordermanagmentEnabled: false,
    searchEnabled: false,
    flashSale: false,
  );

  factory FeatureFlags.fromJson(Map<String, dynamic> json) {
    return FeatureFlags(
      wishlistEnabled: json['wishlist_enabled'] == true,
      enablePaypal: json['enable_paypal'] == true,
      ordermanagmentEnabled: json['ordermanagment_enabled'] == true,
      searchEnabled: json['search_enabled'] == true,
      flashSale: json['flash_sale'] == true,
    );
  }
}
