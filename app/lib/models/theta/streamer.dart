class ThetaStreamer {
	String status;
	Body body;

	ThetaStreamer({this.status, this.body});

	ThetaStreamer.fromJson(Map<String, dynamic> json) {
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
	String userId;
	String liveStreamId;
	String name;
	String alias;
	int score;
	int timestamp;
	LiveStream liveStream;
	List<Programs> programs;
	bool hasAutoTrivia;
	Null triviaGameId;
	bool visible;
	String status;
	bool subscribedTwitch;
	Streamer user;
	int follows;
	String source;
	String streamerId;
	Streamer streamer;
	int startTime;
	String embedUrl;

	Body({this.userId, this.liveStreamId, this.name, this.alias, this.score, this.timestamp, this.liveStream, this.programs, this.hasAutoTrivia, this.triviaGameId, this.visible, this.status, this.subscribedTwitch, this.user, this.follows, this.source, this.streamerId, this.streamer, this.startTime, this.embedUrl});

	Body.fromJson(Map<String, dynamic> json) {
		userId = json['user_id'];
		liveStreamId = json['live_stream_id'];
		name = json['name'];
		alias = json['alias'];
		score = json['score'];
		timestamp = json['timestamp'];
		liveStream = json['live_stream'] != null ? new LiveStream.fromJson(json['live_stream']) : null;
		if (json['programs'] != null) {
			programs = new List<Programs>();
			json['programs'].forEach((v) { programs.add(new Programs.fromJson(v)); });
		}
		hasAutoTrivia = json['has_auto_trivia'];
		triviaGameId = json['trivia_game_id'];
		visible = json['visible'];
		status = json['status'];
		subscribedTwitch = json['subscribed_twitch'];
		user = json['user'] != null ? new Streamer.fromJson(json['user']) : null;
		follows = json['follows'];
		source = json['source'];
		streamerId = json['streamer_id'];
		streamer = json['streamer'] != null ? new Streamer.fromJson(json['streamer']) : null;
		startTime = json['start_time'];
		embedUrl = json['embed_url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['user_id'] = this.userId;
		data['live_stream_id'] = this.liveStreamId;
		data['name'] = this.name;
		data['alias'] = this.alias;
		data['score'] = this.score;
		data['timestamp'] = this.timestamp;
		if (this.liveStream != null) {
      data['live_stream'] = this.liveStream.toJson();
    }
		if (this.programs != null) {
      data['programs'] = this.programs.map((v) => v.toJson()).toList();
    }
		data['has_auto_trivia'] = this.hasAutoTrivia;
		data['trivia_game_id'] = this.triviaGameId;
		data['visible'] = this.visible;
		data['status'] = this.status;
		data['subscribed_twitch'] = this.subscribedTwitch;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		data['follows'] = this.follows;
		data['source'] = this.source;
		data['streamer_id'] = this.streamerId;
		if (this.streamer != null) {
      data['streamer'] = this.streamer.toJson();
    }
		data['start_time'] = this.startTime;
		data['embed_url'] = this.embedUrl;
		return data;
	}
}

class LiveStream {
	String id;
	String gameId;
	Game game;
	String title;
	int score;
	int duration;
	String description;
	int viewCount;
	int likeCount;
	int liveCount;
	int commentCount;
	int timestamp;
	List<String> tags;
	List<String> richTags;
	List<VideoUrls> videoUrls;
	List<String> videoUrlMap;
	String thumbnailUrl;
	Streamer user;
	String event;
	int status;
	List<String> stats;
	bool featured;
	bool visible;
	bool rewarding;
	int baseRewardAmount;
	int rewardAmount;
	int millisecondsToNextReward;
	String raffle;
	String quizzes;
	bool useTheta;

	LiveStream({this.id, this.gameId, this.game, this.title, this.score, this.duration, this.description, this.viewCount, this.likeCount, this.liveCount, this.commentCount, this.timestamp, this.tags, this.richTags, this.videoUrls, this.videoUrlMap, this.thumbnailUrl, this.user, this.event, this.status, this.stats, this.featured, this.visible, this.rewarding, this.baseRewardAmount, this.rewardAmount, this.millisecondsToNextReward, this.raffle, this.quizzes, this.useTheta});

	LiveStream.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		gameId = json['game_id'];
		game = json['game'] != null ? new Game.fromJson(json['game']) : null;
		title = json['title'];
		score = json['score'];
		duration = json['duration'];
		description = json['description'];
		viewCount = json['view_count'];
		likeCount = json['like_count'];
		liveCount = json['live_count'];
		commentCount = json['comment_count'];
		timestamp = json['timestamp'];
		if (json['tags'] != null) {
			tags = new List<String>();
			json['tags'].forEach((v) { tags.add(v); });
		}
		if (json['rich_tags'] != null) {
			richTags = new List<String>();
			json['rich_tags'].forEach((v) { richTags.add(v); });
		}
		if (json['video_urls'] != null) {
			videoUrls = new List<VideoUrls>();
			json['video_urls'].forEach((v) { videoUrls.add(new VideoUrls.fromJson(v)); });
		}
    if(json['video_url_map'] != null){
      videoUrlMap = new List<String>();
      json['video_url_map'].forEach((v) { videoUrlMap.add(v); });
    }
		thumbnailUrl = json['thumbnail_url'];
		user = json['user'] != null ? new Streamer.fromJson(json['user']) : null;
		event = json['event'];
		status = json['status'];
    if(json['stats'] != null){
      stats = new List<String>();
      json['stats'].forEach((v) { stats.add(v); });
    }
		featured = json['featured'];
		visible = json['visible'];
		rewarding = json['rewarding'];
		baseRewardAmount = json['base_reward_amount'];
		rewardAmount = json['reward_amount'];
		millisecondsToNextReward = json['milliseconds_to_next_reward'];
		raffle = json['raffle'];
		quizzes = json['quizzes'];
		useTheta = json['use_theta'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['game_id'] = this.gameId;
		if (this.game != null) {
      data['game'] = this.game.toJson();
    }
		data['title'] = this.title;
		data['score'] = this.score;
		data['duration'] = this.duration;
		data['description'] = this.description;
		data['view_count'] = this.viewCount;
		data['like_count'] = this.likeCount;
		data['live_count'] = this.liveCount;
		data['comment_count'] = this.commentCount;
		data['timestamp'] = this.timestamp;
		if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v).toList();
    }
		if (this.richTags != null) {
      data['rich_tags'] = this.richTags.map((v) => v).toList();
    }
		if (this.videoUrls != null) {
      data['video_urls'] = this.videoUrls.map((v) => v.toJson()).toList();
    }
		if (this.videoUrlMap != null) {
      data['video_url_map'] = this.videoUrlMap.map((v) => v).toList();
    }
		data['thumbnail_url'] = this.thumbnailUrl;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		data['event'] = this.event;
		data['status'] = this.status;
		if (this.stats != null) {
      data['stats'] = this.stats.map((v) => v).toList();
    }
		data['featured'] = this.featured;
		data['visible'] = this.visible;
		data['rewarding'] = this.rewarding;
		data['base_reward_amount'] = this.baseRewardAmount;
		data['reward_amount'] = this.rewardAmount;
		data['milliseconds_to_next_reward'] = this.millisecondsToNextReward;
		data['raffle'] = this.raffle;
		data['quizzes'] = this.quizzes;
		data['use_theta'] = this.useTheta;
		return data;
	}
}

class Game {
	String id;
	String name;
	String shortName;
	String slug;
	String description;
	int score;
	String thumbnailUrl;
	String bannerUrl;
	String categoryUrl;
	String logoUrl;
	String featuredVideos;

	Game({this.id, this.name, this.shortName, this.slug, this.description, this.score, this.thumbnailUrl, this.bannerUrl, this.categoryUrl, this.logoUrl, this.featuredVideos});

	Game.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		shortName = json['short_name'];
		slug = json['slug'];
		description = json['description'];
		score = json['score'];
		thumbnailUrl = json['thumbnail_url'];
		bannerUrl = json['banner_url'];
		categoryUrl = json['category_url'];
		logoUrl = json['logo_url'];
		featuredVideos = json['featured_videos'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['short_name'] = this.shortName;
		data['slug'] = this.slug;
		data['description'] = this.description;
		data['score'] = this.score;
		data['thumbnail_url'] = this.thumbnailUrl;
		data['banner_url'] = this.bannerUrl;
		data['category_url'] = this.categoryUrl;
		data['logo_url'] = this.logoUrl;
		data['featured_videos'] = this.featuredVideos;
		return data;
	}
}

class VideoUrls {
	String name;
	String iconUrl;
	String type;
	String resolution;
	String url;

	VideoUrls({this.name, this.iconUrl, this.type, this.resolution, this.url});

	VideoUrls.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		iconUrl = json['icon_url'];
		type = json['type'];
		resolution = json['resolution'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['icon_url'] = this.iconUrl;
		data['type'] = this.type;
		data['resolution'] = this.resolution;
		data['url'] = this.url;
		return data;
	}
}

class User {
	String id;
	String username;
	String avatarUrl;
	String type;

	User({this.id, this.username, this.avatarUrl, this.type});

	User.fromJson(Map<String, dynamic> json) {
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

class Programs {
	String id;
	String name;
	String gameId;
	String channelId;
	String type;
	int timestamp;
	int endTimestamp;
	int priority;
	String status;
	String sourceReference;
	String metadata;
	String raffles;
	String triviaId;
	String trivia;
	String createdPollIds;
	String openPollIds;
	String closedPollIds;
	String polls;
	String streamerId;
	Streamer streamer;

	Programs({this.id, this.name, this.gameId, this.channelId, this.type, this.timestamp, this.endTimestamp, this.priority, this.status, this.sourceReference, this.metadata, this.raffles, this.triviaId, this.trivia, this.createdPollIds, this.openPollIds, this.closedPollIds, this.polls, this.streamerId, this.streamer});

	Programs.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		gameId = json['game_id'];
		channelId = json['channel_id'];
		type = json['type'];
		timestamp = json['timestamp'];
		endTimestamp = json['end_timestamp'];
		priority = json['priority'];
		status = json['status'];
		sourceReference = json['source_reference'];
		metadata = json['metadata'];
		raffles = json['raffles'];
		triviaId = json['trivia_id'];
		trivia = json['trivia'];
		createdPollIds = json['created_poll_ids'];
		openPollIds = json['open_poll_ids'];
		closedPollIds = json['closed_poll_ids'];
		polls = json['polls'];
		streamerId = json['streamer_id'];
		streamer = json['streamer'] != null ? new Streamer.fromJson(json['streamer']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['game_id'] = this.gameId;
		data['channel_id'] = this.channelId;
		data['type'] = this.type;
		data['timestamp'] = this.timestamp;
		data['end_timestamp'] = this.endTimestamp;
		data['priority'] = this.priority;
		data['status'] = this.status;
		data['source_reference'] = this.sourceReference;
		data['metadata'] = this.metadata;
		data['raffles'] = this.raffles;
		data['trivia_id'] = this.triviaId;
		data['trivia'] = this.trivia;
		data['created_poll_ids'] = this.createdPollIds;
		data['open_poll_ids'] = this.openPollIds;
		data['closed_poll_ids'] = this.closedPollIds;
		data['polls'] = this.polls;
		data['streamer_id'] = this.streamerId;
		if (this.streamer != null) {
      data['streamer'] = this.streamer.toJson();
    }
		return data;
	}
}

class Streamer {
	String id;
	String username;
	String avatarUrl;
	String type;

	Streamer({this.id, this.username, this.avatarUrl, this.type});

	Streamer.fromJson(Map<String, dynamic> json) {
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

