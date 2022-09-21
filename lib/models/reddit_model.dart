// https://www.reddit.com/user/USER_NAME/about.json

class RedditModel {
  final String? kind;
  final Data? data;

  RedditModel({
    this.kind,
    this.data,
  });

  RedditModel.fromJson(Map<String, dynamic> json)
      : kind = json['kind'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null;
}

class Data {
  final String? snoovatarImg;
  final int? numFriends;
  final bool? verified;
  final int? coins;
  final bool? hasPaypalSubscription;
  final bool? hasSubscribedToPremium;
  final bool? over18;
  final bool? isGold;
  final bool? isMod;
  final int? awarderKarma;
  final String? iconImg;
  final int? awardeeKarma;
  final int? linkKarma;
  final int? totalKarma;
  final int? inboxCount;
  final String? name;
  final int? created;
  final bool? hasVerifiedEmail;
  final int? goldCreddits;
  final int? createdUtc;
  final bool? hasIosSubscription;
  final int? commentKarma;

  Data(
    this.awardeeKarma, {
    this.snoovatarImg,
    this.numFriends,
    this.verified,
    this.coins,
    this.hasPaypalSubscription,
    this.hasSubscribedToPremium,
    this.over18,
    this.isGold,
    this.isMod,
    this.awarderKarma,
    this.iconImg,
    this.linkKarma,
    this.totalKarma,
    this.inboxCount,
    this.name,
    this.created,
    this.hasVerifiedEmail,
    this.goldCreddits,
    this.createdUtc,
    this.hasIosSubscription,
    this.commentKarma,
  });

  Data.fromJson(Map<String, dynamic> json)
      : snoovatarImg = json['snoovatar_img'] as String?,
        numFriends = json['num_friends'] as int?,
        verified = json['verified'] as bool?,
        coins = json['coins'] as int?,
        hasPaypalSubscription = json['has_paypal_subscription'] as bool?,
        hasSubscribedToPremium = json['has_subscribed_to_premium'] as bool?,
        over18 = json['over_18'] as bool?,
        isGold = json['is_gold'] as bool?,
        isMod = json['is_mod'] as bool?,
        awarderKarma = json['awarder_karma'] as int?,
        iconImg = json['icon_img'] as String?,
        awardeeKarma = json['awardee_karma'] as int?,
        linkKarma = json['link_karma'] as int?,
        totalKarma = json['total_karma'] as int?,
        inboxCount = json['inbox_count'] as int?,
        name = json['name'] as String?,
        created = json['created'] as int?,
        hasVerifiedEmail = json['has_verified_email'] as bool?,
        goldCreddits = json['gold_creddits'] as int?,
        createdUtc = json['created_utc'] as int?,
        hasIosSubscription = json['has_ios_subscription'] as bool?,
        commentKarma = json['comment_karma'] as int?;
}
