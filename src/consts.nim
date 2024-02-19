# SPDX-License-Identifier: AGPL-3.0-only
import uri, sequtils, strutils

const
  consumerKey* = "3nVuSoBZnx6U4vzUxf5w"
  consumerSecret* = "Bcs59EFbbsdF6Sl9Ng71smgStWEGwXXKSjYvPVt7qys"

  api = parseUri("https://api.twitter.com")
  activate* = $(api / "1.1/guest/activate.json")

  photoRail* = api / "1.1/statuses/media_timeline.json"

  graphql = api / "graphql"
  graphUser* = graphql / "AJO430nSYOou_HJ-GIRzTQ/UserResultByScreenNameQuery"
  graphUserById* = graphql / "8BTUdO2H4nAu26mgdE7_aQ-A/UserResultByIdQuery"
  graphUserTweets* = graphql / "3JNH4e9dq1BifLxAa3UMWg/UserWithProfileTweetsQueryV2"
  graphUserTweetsAndReplies* = graphql / "WaFZV8TcAiesKXLhcL14LQ/UserWithProfileTweetsAndRepliesQueryV2"
  graphUserMedia* = graphql / "HGadlr1FG_i-Nk3ms9oysw/MediaTimelineV2"
  graphTweet* = graphql / "1ra1rFDRUquziGxksi5ifg/TweetDetail"
  graphTweetResult* = graphql / "-4KJkAxwnr5ziutM9brE9w/TweetResultByIdQuery"
  graphSearchTimeline* = graphql / "kk6ixU4oM4SKooHuVYHe7Q/SearchTimeline"
  graphListById* = graphql / "iTpgCtbdxrsJfyx0cFjHqg/ListByRestId"
  graphListBySlug* = graphql / "-kmqNvm5Y-cVrfvBy6docg/ListBySlug"
  graphListMembers* = graphql / "P4NpVZDqUD_7MEM84L-8nw/ListMembers"
  graphListTweets* = graphql / "eoCr0usuUL-m3o_BL7ArgA/ListTimeline"

  timelineParams* = {
    "include_can_media_tag": "1",
    "include_cards": "1",
    "include_entities": "1",
    "include_profile_interstitial_type": "0",
    "include_quote_count": "0",
    "include_reply_count": "0",
    "include_user_entities": "0",
    "include_ext_reply_count": "0",
    "include_ext_media_color": "0",
    "cards_platform": "Web-13",
    "tweet_mode": "extended",
    "send_error_codes": "1",
    "simple_quoted_tweet": "1"
  }.toSeq

  gqlFeatures* = """{
  "android_graphql_skip_api_media_color_palette": false,
  "blue_business_profile_image_shape_enabled": false,
  "creator_subscriptions_subscription_count_enabled": false,
  "creator_subscriptions_tweet_preview_api_enabled": true,
  "freedom_of_speech_not_reach_fetch_enabled": false,
  "graphql_is_translatable_rweb_tweet_is_translatable_enabled": false,
  "hidden_profile_likes_enabled": false,
  "highlights_tweets_tab_ui_enabled": false,
  "interactive_text_enabled": false,
  "longform_notetweets_consumption_enabled": true,
  "longform_notetweets_inline_media_enabled": false,
  "longform_notetweets_richtext_consumption_enabled": true,
  "longform_notetweets_rich_text_read_enabled": false,
  "responsive_web_edit_tweet_api_enabled": false,
  "responsive_web_enhance_cards_enabled": false,
  "responsive_web_graphql_exclude_directive_enabled": true,
  "responsive_web_graphql_skip_user_profile_image_extensions_enabled": false,
  "responsive_web_graphql_timeline_navigation_enabled": false,
  "responsive_web_media_download_video_enabled": false,
  "responsive_web_text_conversations_enabled": false,
  "responsive_web_twitter_article_tweet_consumption_enabled": false,
  "responsive_web_twitter_blue_verified_badge_is_enabled": true,
  "rweb_lists_timeline_redesign_enabled": true,
  "spaces_2022_h2_clipping": true,
  "spaces_2022_h2_spaces_communities": true,
  "standardized_nudges_misinfo": false,
  "subscriptions_verification_info_enabled": true,
  "subscriptions_verification_info_reason_enabled": true,
  "subscriptions_verification_info_verified_since_enabled": true,
  "super_follow_badge_privacy_enabled": false,
  "super_follow_exclusive_tweet_notifications_enabled": false,
  "super_follow_tweet_api_enabled": false,
  "super_follow_user_api_enabled": false,
  "tweet_awards_web_tipping_enabled": false,
  "tweet_with_visibility_results_prefer_gql_limited_actions_policy_enabled": false,
  "tweetypie_unmention_optimization_enabled": false,
  "unified_cards_ad_metadata_container_dynamic_card_content_query_enabled": false,
  "verified_phone_label_enabled": false,
  "vibe_api_enabled": false,
  "view_counts_everywhere_api_enabled": false,
  "immersive_video_status_linkable_timestamps": false
}""".replace(" ", "").replace("\n", "")

  tweetVariables* = """{
  "focalTweetId": "$1",
  $2
  "includeHasBirdwatchNotes": false,
  "includePromotedContent": false,
  "withBirdwatchNotes": false,
  "withVoice": false,
  "withV2Timeline": true
}""".replace(" ", "").replace("\n", "")

#   oldUserTweetsVariables* = """{
#   "userId": "$1", $2
#   "count": 20,
#   "includePromotedContent": false,
#   "withDownvotePerspective": false,
#   "withReactionsMetadata": false,
#   "withReactionsPerspective": false,
#   "withVoice": false,
#   "withV2Timeline": true
# }
# """

  userTweetsVariables* = """{
  "rest_id": "$1", $2
  "count": 20
}"""

  listTweetsVariables* = """{
  "rest_id": "$1", $2
  "count": 20
}"""
