class ThetaGiftableI {
  String status;
  Body body;

  ThetaGiftableI({this.status, this.body});

  ThetaGiftableI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }
}

class Body {
  List<ItemForge> itemForge;
  List<SupplyDrop> supplyDrop;
  List<CustomPrize> customPrize;
  List<Inventory> inventory;

  Body({this.itemForge, this.supplyDrop, this.customPrize, this.inventory});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['item_forge'] != null) {
      itemForge = new List<ItemForge>();
      json['item_forge'].forEach((v) {
        itemForge.add(new ItemForge.fromJson(v));
      });
    }
    if (json['supply_drop'] != null) {
      supplyDrop = new List<SupplyDrop>();
      json['supply_drop'].forEach((v) {
        supplyDrop.add(new SupplyDrop.fromJson(v));
      });
    }
    if (json['custom_prize'] != null) {
      customPrize = new List<CustomPrize>();
      json['custom_prize'].forEach((v) {
        customPrize.add(new CustomPrize.fromJson(v));
      });
    }
    if (json['inventory'] != null) {
      inventory = new List<Inventory>();
      json['inventory'].forEach((v) {
        inventory.add(new Inventory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemForge != null) {
      data['item_forge'] = this.itemForge.map((v) => v.toJson()).toList();
    }
    if (this.supplyDrop != null) {
      data['supply_drop'] = this.supplyDrop.map((v) => v.toJson()).toList();
    }
    if (this.customPrize != null) {
      data['custom_prize'] = this.customPrize.map((v) => v.toJson()).toList();
    }
    if (this.inventory != null) {
      data['inventory'] = this.inventory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemForge {
  String id;
  String blockchainId;
  String creatorId;
  Creator creator;
  String ownerId;
  Creator owner;
  String metadataId;
  Metadata metadata;
  String kind;

  ItemForge(
      {this.id,
      this.blockchainId,
      this.creatorId,
      this.creator,
      this.ownerId,
      this.owner,
      this.metadataId,
      this.metadata,
      this.kind});

  ItemForge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blockchainId = json['blockchain_id'];
    creatorId = json['creator_id'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    ownerId = json['owner_id'];
    owner = json['owner'] != null ? new Creator.fromJson(json['owner']) : null;
    metadataId = json['metadata_id'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['blockchain_id'] = this.blockchainId;
    data['creator_id'] = this.creatorId;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    data['owner_id'] = this.ownerId;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['metadata_id'] = this.metadataId;
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    data['kind'] = this.kind;
    return data;
  }
}

class Creator {
  String id;
  String username;
  String avatarUrl;
  String type;

  Creator({this.id, this.username, this.avatarUrl, this.type});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatarUrl = json['avatar_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar_url'] = this.avatarUrl;
    data['type'] = this.type;
    return data;
  }
}

class Metadata {
  String name;
  ImageUrls imageUrls;

  Metadata({this.name, this.imageUrls});

  Metadata.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrls = json['image_urls'] != null
        ? new ImageUrls.fromJson(json['image_urls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.imageUrls != null) {
      data['image_urls'] = this.imageUrls.toJson();
    }
    return data;
  }
}

class ImageUrls {
  String large;

  ImageUrls({this.large});

  ImageUrls.fromJson(Map<String, dynamic> json) {
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['large'] = this.large;
    return data;
  }
}

class SupplyDrop {
  String id;
  String name;
  String description;
  String type;
  String thumbnailUrl;
  String link;
  List<String> bundle;
  List<String> bundleObjects;
  String crateId;
  String buffId;
  String coinCapBuffId;
  int quantity;
  double value;
  double tfuelPrice;
  int sellbackTfuelPrice;
  bool isTfuelPriceDynamic;
  bool isSellbackTfuelPriceDynamic;
  double discount;
  int bonus;
  int score;
  String rarity;
  String winnerId;
  String winner;
  int winnerTickets;
  int timestamp;
  bool inShop;
  int numInShop;
  List<String> bonusObjectIds;
  List<String> bonusObjects;
  List<String> streamers;
  String subType;
  String subject;
  String tag;
  List<String> inclCountries;
  List<String> exclCountries;
  String templateId;

  SupplyDrop(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.thumbnailUrl,
      this.link,
      this.bundle,
      this.bundleObjects,
      this.crateId,
      this.buffId,
      this.coinCapBuffId,
      this.quantity,
      this.value,
      this.tfuelPrice,
      this.sellbackTfuelPrice,
      this.isTfuelPriceDynamic,
      this.isSellbackTfuelPriceDynamic,
      this.discount,
      this.bonus,
      this.score,
      this.rarity,
      this.winnerId,
      this.winner,
      this.winnerTickets,
      this.timestamp,
      this.inShop,
      this.numInShop,
      this.bonusObjectIds,
      this.bonusObjects,
      this.streamers,
      this.subType,
      this.subject,
      this.tag,
      this.inclCountries,
      this.exclCountries,
      this.templateId});

  SupplyDrop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    thumbnailUrl = json['thumbnail_url'];
    link = json['link'];
    bundle = json['bundle'].cast<String>();
    bundleObjects = json['bundle_objects'];
    crateId = json['crate_id'];
    buffId = json['buff_id'];
    coinCapBuffId = json['coin_cap_buff_id'];
    quantity = json['quantity'];
    value = json['value'];
    tfuelPrice = json['tfuel_price'];
    sellbackTfuelPrice = json['sellback_tfuel_price'];
    isTfuelPriceDynamic = json['is_tfuel_price_dynamic'];
    isSellbackTfuelPriceDynamic = json['is_sellback_tfuel_price_dynamic'];
    discount = json['discount'];
    bonus = json['bonus'];
    score = json['score'];
    rarity = json['rarity'];
    winnerId = json['winner_id'];
    winner = json['winner'];
    winnerTickets = json['winner_tickets'];
    timestamp = json['timestamp'];
    inShop = json['in_shop'];
    numInShop = json['num_in_shop'];
    if (json['bonus_object_ids'] != null) {
      bonusObjectIds = new List<String>();
      json['bonus_object_ids'].forEach((v) {
        bonusObjectIds.add(v);
      });
    }
    bonusObjects = json['bonus_objects'];
    streamers = json['streamers'];
    subType = json['sub_type'];
    subject = json['subject'];
    tag = json['tag'];
    inclCountries = json['incl_countries'];
    exclCountries = json['excl_countries'].cast<String>();
    templateId = json['template_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['link'] = this.link;
    data['bundle'] = this.bundle;
    data['bundle_objects'] = this.bundleObjects;
    data['crate_id'] = this.crateId;
    data['buff_id'] = this.buffId;
    data['coin_cap_buff_id'] = this.coinCapBuffId;
    data['quantity'] = this.quantity;
    data['value'] = this.value;
    data['tfuel_price'] = this.tfuelPrice;
    data['sellback_tfuel_price'] = this.sellbackTfuelPrice;
    data['is_tfuel_price_dynamic'] = this.isTfuelPriceDynamic;
    data['is_sellback_tfuel_price_dynamic'] = this.isSellbackTfuelPriceDynamic;
    data['discount'] = this.discount;
    data['bonus'] = this.bonus;
    data['score'] = this.score;
    data['rarity'] = this.rarity;
    data['winner_id'] = this.winnerId;
    data['winner'] = this.winner;
    data['winner_tickets'] = this.winnerTickets;
    data['timestamp'] = this.timestamp;
    data['in_shop'] = this.inShop;
    data['num_in_shop'] = this.numInShop;
    if (this.bonusObjectIds != null) {
      data['bonus_object_ids'] =
          this.bonusObjectIds.map((v) => v).toList();
    }
    data['bonus_objects'] = this.bonusObjects;
    data['streamers'] = this.streamers;
    data['sub_type'] = this.subType;
    data['subject'] = this.subject;
    data['tag'] = this.tag;
    data['incl_countries'] = this.inclCountries;
    data['excl_countries'] = this.exclCountries;
    data['template_id'] = this.templateId;
    return data;
  }
}

class CustomPrize {
  String name;
  String description;
  String thumbnailUrl;
  String type;
  String link;
  String note;
  String contactInfo;
  String subject;
  int score;
  String winner;
  String winnerId;
  int timestamp;
  int winnerTickets;
  String id;

  CustomPrize(
      {this.name,
      this.description,
      this.thumbnailUrl,
      this.type,
      this.link,
      this.note,
      this.contactInfo,
      this.subject,
      this.score,
      this.winner,
      this.winnerId,
      this.timestamp,
      this.winnerTickets,
      this.id});

  CustomPrize.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    thumbnailUrl = json['thumbnail_url'];
    type = json['type'];
    link = json['link'];
    note = json['note'];
    contactInfo = json['contact_info'];
    subject = json['subject'];
    score = json['score'];
    winner = json['winner'];
    winnerId = json['winner_id'];
    timestamp = json['timestamp'];
    winnerTickets = json['winner_tickets'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['type'] = this.type;
    data['link'] = this.link;
    data['note'] = this.note;
    data['contact_info'] = this.contactInfo;
    data['subject'] = this.subject;
    data['score'] = this.score;
    data['winner'] = this.winner;
    data['winner_id'] = this.winnerId;
    data['timestamp'] = this.timestamp;
    data['winner_tickets'] = this.winnerTickets;
    data['id'] = this.id;
    return data;
  }
}

class Inventory {
  String id;
  String userId;
  bool isSystem;
  String subjectId;
  Subject subject;
  String type;
  Item item;
  String status;
  String note;
  int timestamp;
  int claimedTimestamp;
  int coins;
  int userCoins;
  int userTfuel;
  String userOpenXacts;
  String xactId;
  String ttl;
  String source;
  String sourceDesc;
  String name;
  String thumbnailUrl;
  String link;

  Inventory(
      {this.id,
      this.userId,
      this.isSystem,
      this.subjectId,
      this.subject,
      this.type,
      this.item,
      this.status,
      this.note,
      this.timestamp,
      this.claimedTimestamp,
      this.coins,
      this.userCoins,
      this.userTfuel,
      this.userOpenXacts,
      this.xactId,
      this.ttl,
      this.source,
      this.sourceDesc,
      this.name,
      this.thumbnailUrl,
      this.link});

  Inventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isSystem = json['is_system'];
    subjectId = json['subject_id'];
    subject =
        json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    type = json['type'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    status = json['status'];
    note = json['note'];
    timestamp = json['timestamp'];
    claimedTimestamp = json['claimed_timestamp'];
    coins = json['coins'];
    userCoins = json['user_coins'];
    userTfuel = json['user_tfuel'];
    userOpenXacts = json['user_open_xacts'];
    xactId = json['xact_id'];
    ttl = json['ttl'];
    source = json['source'];
    sourceDesc = json['source_desc'];
    name = json['name'];
    thumbnailUrl = json['thumbnail_url'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['is_system'] = this.isSystem;
    data['subject_id'] = this.subjectId;
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    data['type'] = this.type;
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    data['status'] = this.status;
    data['note'] = this.note;
    data['timestamp'] = this.timestamp;
    data['claimed_timestamp'] = this.claimedTimestamp;
    data['coins'] = this.coins;
    data['user_coins'] = this.userCoins;
    data['user_tfuel'] = this.userTfuel;
    data['user_open_xacts'] = this.userOpenXacts;
    data['xact_id'] = this.xactId;
    data['ttl'] = this.ttl;
    data['source'] = this.source;
    data['source_desc'] = this.sourceDesc;
    data['name'] = this.name;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['link'] = this.link;
    return data;
  }
}

class Subject {
  String id;
  String username;
  String avatarUrl;
  String type;
  String name;
  String description;
  String thumbnailUrl;
  String link;
  List<String> bundle;
  List<String> bundleObjects;
  String crateId;
  String buffId;
  String coinCapBuffId;
  int quantity;
  int value;
  int tfuelPrice;
  int sellbackTfuelPrice;
  bool isTfuelPriceDynamic;
  bool isSellbackTfuelPriceDynamic;
  int discount;
  int bonus;
  int score;
  String rarity;
  String winnerId;
  String winner;
  int winnerTickets;
  int timestamp;
  bool inShop;
  int numInShop;
  List<String> bonusObjectIds;
  List<String> bonusObjects;
  List<String> streamers;
  String subType;
  String subject;
  String tag;
  List<String> inclCountries;
  List<String> exclCountries;
  String templateId;

  Subject(
      {this.id,
      this.username,
      this.avatarUrl,
      this.type,
      this.name,
      this.description,
      this.thumbnailUrl,
      this.link,
      this.bundle,
      this.bundleObjects,
      this.crateId,
      this.buffId,
      this.coinCapBuffId,
      this.quantity,
      this.value,
      this.tfuelPrice,
      this.sellbackTfuelPrice,
      this.isTfuelPriceDynamic,
      this.isSellbackTfuelPriceDynamic,
      this.discount,
      this.bonus,
      this.score,
      this.rarity,
      this.winnerId,
      this.winner,
      this.winnerTickets,
      this.timestamp,
      this.inShop,
      this.numInShop,
      this.bonusObjectIds,
      this.bonusObjects,
      this.streamers,
      this.subType,
      this.subject,
      this.tag,
      this.inclCountries,
      this.exclCountries,
      this.templateId});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatarUrl = json['avatar_url'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    thumbnailUrl = json['thumbnail_url'];
    link = json['link'];
    bundle = json['bundle'].cast<String>();
    bundleObjects = json['bundle_objects'];
    crateId = json['crate_id'];
    buffId = json['buff_id'];
    coinCapBuffId = json['coin_cap_buff_id'];
    quantity = json['quantity'];
    value = json['value'];
    tfuelPrice = json['tfuel_price'];
    sellbackTfuelPrice = json['sellback_tfuel_price'];
    isTfuelPriceDynamic = json['is_tfuel_price_dynamic'];
    isSellbackTfuelPriceDynamic = json['is_sellback_tfuel_price_dynamic'];
    discount = json['discount'];
    bonus = json['bonus'];
    score = json['score'];
    rarity = json['rarity'];
    winnerId = json['winner_id'];
    winner = json['winner'];
    winnerTickets = json['winner_tickets'];
    timestamp = json['timestamp'];
    inShop = json['in_shop'];
    numInShop = json['num_in_shop'];
    if (json['bonus_object_ids'] != null) {
      bonusObjectIds = new List<String>();
      json['bonus_object_ids'].forEach((v) {
        bonusObjectIds.add(v);
      });
    }
    bonusObjects = json['bonus_objects'];
    streamers = json['streamers'];
    subType = json['sub_type'];
    subject = json['subject'];
    tag = json['tag'];
    inclCountries = json['incl_countries'];
    exclCountries = json['excl_countries'];
    templateId = json['template_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar_url'] = this.avatarUrl;
    data['type'] = this.type;
    data['name'] = this.name;
    data['description'] = this.description;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['link'] = this.link;
    data['bundle'] = this.bundle;
    data['bundle_objects'] = this.bundleObjects;
    data['crate_id'] = this.crateId;
    data['buff_id'] = this.buffId;
    data['coin_cap_buff_id'] = this.coinCapBuffId;
    data['quantity'] = this.quantity;
    data['value'] = this.value;
    data['tfuel_price'] = this.tfuelPrice;
    data['sellback_tfuel_price'] = this.sellbackTfuelPrice;
    data['is_tfuel_price_dynamic'] = this.isTfuelPriceDynamic;
    data['is_sellback_tfuel_price_dynamic'] = this.isSellbackTfuelPriceDynamic;
    data['discount'] = this.discount;
    data['bonus'] = this.bonus;
    data['score'] = this.score;
    data['rarity'] = this.rarity;
    data['winner_id'] = this.winnerId;
    data['winner'] = this.winner;
    data['winner_tickets'] = this.winnerTickets;
    data['timestamp'] = this.timestamp;
    data['in_shop'] = this.inShop;
    data['num_in_shop'] = this.numInShop;
    if (this.bonusObjectIds != null) {
      data['bonus_object_ids'] =
          this.bonusObjectIds.map((v) => v).toList();
    }
    data['bonus_objects'] = this.bonusObjects;
    data['streamers'] = this.streamers;
    data['sub_type'] = this.subType;
    data['subject'] = this.subject;
    data['tag'] = this.tag;
    data['incl_countries'] = this.inclCountries;
    data['excl_countries'] = this.exclCountries;
    data['template_id'] = this.templateId;
    return data;
  }
}

class Item {
  String id;
  String name;
  String description;
  String type;
  String thumbnailUrl;
  String link;
  List<String> bundle;
  List<String> bundleObjects;
  String crateId;
  String buffId;
  String coinCapBuffId;
  int quantity;
  int value;
  double tfuelPrice;
  double sellbackTfuelPrice;
  bool isTfuelPriceDynamic;
  bool isSellbackTfuelPriceDynamic;
  double discount;
  int bonus;
  int score;
  String rarity;
  String winnerId;
  String winner;
  String winnerTickets;
  int timestamp;
  bool inShop;
  int numInShop;
  List<String> bonusObjectIds;
  List<String>  bonusObjects;
  List<String>  streamers;
  String subType;
  String subject;
  String tag;
  List<String> inclCountries;
  List<String> exclCountries;
  String templateId;
  int startTimestamp;
  int duration;
  int remainingTime;

  Item(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.thumbnailUrl,
      this.link,
      this.bundle,
      this.bundleObjects,
      this.crateId,
      this.buffId,
      this.coinCapBuffId,
      this.quantity,
      this.value,
      this.tfuelPrice,
      this.sellbackTfuelPrice,
      this.isTfuelPriceDynamic,
      this.isSellbackTfuelPriceDynamic,
      this.discount,
      this.bonus,
      this.score,
      this.rarity,
      this.winnerId,
      this.winner,
      this.winnerTickets,
      this.timestamp,
      this.inShop,
      this.numInShop,
      this.bonusObjectIds,
      this.bonusObjects,
      this.streamers,
      this.subType,
      this.subject,
      this.tag,
      this.inclCountries,
      this.exclCountries,
      this.templateId,
      this.startTimestamp,
      this.duration,
      this.remainingTime});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    thumbnailUrl = json['thumbnail_url'];
    link = json['link'];
    if (json['bundle'] != null) {
      bundle = new List<String>();
      json['bundle'].forEach((v) {
        bundle.add(v);
      });
    }
    bundleObjects = json['bundle_objects'];
    crateId = json['crate_id'];
    buffId = json['buff_id'];
    coinCapBuffId = json['coin_cap_buff_id'];
    quantity = json['quantity'];
    value = json['value'];
    tfuelPrice = json['tfuel_price'];
    sellbackTfuelPrice = json['sellback_tfuel_price'];
    isTfuelPriceDynamic = json['is_tfuel_price_dynamic'];
    isSellbackTfuelPriceDynamic = json['is_sellback_tfuel_price_dynamic'];
    discount = json['discount'];
    bonus = json['bonus'];
    score = json['score'];
    rarity = json['rarity'];
    winnerId = json['winner_id'];
    winner = json['winner'];
    winnerTickets = json['winner_tickets'];
    timestamp = json['timestamp'];
    inShop = json['in_shop'];
    numInShop = json['num_in_shop'];
    if (json['bonus_object_ids'] != null) {
      bonusObjectIds = new List<String>();
      json['bonus_object_ids'].forEach((v) {
        bonusObjectIds.add(v);
      });
    }
    bonusObjects = json['bonus_objects'];
    streamers = json['streamers'];
    subType = json['sub_type'];
    subject = json['subject'];
    tag = json['tag'];
    inclCountries = json['incl_countries'];
    exclCountries = json['excl_countries'].cast<String>();
    templateId = json['template_id'];
    startTimestamp = json['start_timestamp'];
    duration = json['duration'];
    remainingTime = json['remaining_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['link'] = this.link;
    if (this.bundle != null) {
      data['bundle'] = this.bundle.map((v) => v).toList();
    }
    data['bundle_objects'] = this.bundleObjects;
    data['crate_id'] = this.crateId;
    data['buff_id'] = this.buffId;
    data['coin_cap_buff_id'] = this.coinCapBuffId;
    data['quantity'] = this.quantity;
    data['value'] = this.value;
    data['tfuel_price'] = this.tfuelPrice;
    data['sellback_tfuel_price'] = this.sellbackTfuelPrice;
    data['is_tfuel_price_dynamic'] = this.isTfuelPriceDynamic;
    data['is_sellback_tfuel_price_dynamic'] = this.isSellbackTfuelPriceDynamic;
    data['discount'] = this.discount;
    data['bonus'] = this.bonus;
    data['score'] = this.score;
    data['rarity'] = this.rarity;
    data['winner_id'] = this.winnerId;
    data['winner'] = this.winner;
    data['winner_tickets'] = this.winnerTickets;
    data['timestamp'] = this.timestamp;
    data['in_shop'] = this.inShop;
    data['num_in_shop'] = this.numInShop;
    if (this.bonusObjectIds != null) {
      data['bonus_object_ids'] =
          this.bonusObjectIds.map((v) => v).toList();
    }
    data['bonus_objects'] = this.bonusObjects;
    data['streamers'] = this.streamers;
    data['sub_type'] = this.subType;
    data['subject'] = this.subject;
    data['tag'] = this.tag;
    data['incl_countries'] = this.inclCountries;
    data['excl_countries'] = this.exclCountries;
    data['template_id'] = this.templateId;
    data['start_timestamp'] = this.startTimestamp;
    data['duration'] = this.duration;
    data['remaining_time'] = this.remainingTime;
    return data;
  }
}
