class Partner {
  final String partnerName;
  final String address;
  final String description;
  final String? imgUrl;
  final List<PartnerService> partnerServices;

  Partner({
    required this.partnerName,
    required this.address,
    required this.description,
    this.imgUrl,
    required this.partnerServices,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    List<dynamic> servicesJson = json['partnerServices'];
    List<PartnerService> services =
        servicesJson.map((json) => PartnerService.fromJson(json)).toList();

    return Partner(
      partnerName: json['partnerName'],
      address: json['address'],
      description: json['description'],
      imgUrl: json['imgUrl'],
      partnerServices: services,
    );
  }
}

class PartnerService {
  final String name;
  final int duration;
  final int status;
  final String description;
  final int price;
  final int bookedQuantity;
  final List<Category> categories;

  PartnerService({
    required this.name,
    required this.duration,
    required this.status,
    required this.description,
    required this.price,
    required this.bookedQuantity,
    required this.categories,
  });

  factory PartnerService.fromJson(Map<String, dynamic> json) {
    List<dynamic> categoriesJson = json['categories'];
    List<Category> categories =
        categoriesJson.map((json) => Category.fromJson(json)).toList();

    return PartnerService(
      name: json['name'],
      duration: json['duration'],
      status: json['status'],
      description: json['description'],
      price: json['price'],
      bookedQuantity: json['bookedQuantity'],
      categories: categories,
    );
  }
}

class Category {
  final int categoryId;
  final String category;
  final String code;
  final String createdBy;
  final String createdDate;
  final String lastUpdate;
  final String updatedBy;

  Category({
    required this.categoryId,
    required this.category,
    required this.code,
    required this.createdBy,
    required this.createdDate,
    required this.lastUpdate,
    required this.updatedBy,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      category: json['category'],
      code: json['code'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'],
      lastUpdate: json['lastUpdate'],
      updatedBy: json['updatedBy'],
    );
  }
}
