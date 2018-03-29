require 'twitter'
require 'yaml'
require 'pry'

class TwitterApi
  attr_reader :client

  @@hashtags_all = []

  def initialize
    keys = YAML.load_file('application.yml')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = keys['CONSUMER_KEY']
      config.consumer_secret     = keys['CONSUMER_SECRET']
      config.access_token        = keys['ACCESS_TOKEN']
      config.access_token_secret = keys['ACCESS_TOKEN_SECRET']
    end
  end

  def self.hashtags
    @@hashtags_all.flatten.uniq
  end

  def pull_user_data(data)
    data.each do |item|
      #User.all.where(user_code: item.user.id).exists? ? next : User.create(screen_name: item.user.screen_name, name: item.user.name, followers_count: item.user.followers_count, friends_count: item.user.friends_count, timezone: item.user.time_zone, statuses_count: item.user.statuses_count, profile_image_url: item.user.profile_image_url, user_code: item.user.id)
      if User.find_by(user_code: item.user.id) == nil
        User.create(
          screen_name: item.user.screen_name,
          name: item.user.name,
          followers_count: item.user.followers_count,
          friends_count: item.user.friends_count,
          timezone: item.user.time_zone,
          statuses_count: item.user.statuses_count,
          profile_image_url: item.user.profile_image_url,
          user_code: item.user.id
        )
      end
    end
  end

  def pull_tweet_data(data)
    data.each do |item|
      #Tweet.create(user_id: (User.find_by(screen_name: item.user.screen_name).id), text: item.text, creation_time: item.created_at, favorite_count: item.favorite_count, retweet_count: item.retweet_count, lang: item.lang, tweet_code: item.id)
      if Tweet.find_by(tweet_code: item.id) == nil
        Tweet.create(
          user_id: User.find_by(user_code: item.user.id).id,
          text: item.text,
          creation_time: item.created_at,
          favorite_count: item.favorite_count,
          retweet_count: item.retweet_count,
          lang: item.lang,
          tweet_code: item.id
          hashtags: item.attrs[:entities][:hashtags].map {|tag| tag[:text].downcase}.uniq
        )
      end
    end
  end

  def pull_topic_data(data)
    data.each do |item|
      if item.attrs[:entities][:hashtags].count == 0
        # No topics to create
        next
      else
        # Create topics based on those hashtags
        item.attrs[:entities][:hashtags].each do |tag|
          # But only if the topic doesn't already exist
          if Topic.find_by(name: tag[:text].downcase) == nil
            Topic.create(
              name: tag[:text].downcase
            )
          end
        end
      end
    end
  end

  def create_tweet_topic_relationship(data, term)
    data.each do |item|
      # Checking if we need to create multiple TweetTopic rows
      if item.attrs[:entities][:hashtags].count == 0
        # Just one... create the TweetTopic
        TweetTopic.create(
          tweet_id: Tweet.find_by(tweet_code: item.id).id,
          topic_id: Topic.find_by(name: term).id
        )
      else
        # Gather the hashtags, but make sure there are no dupes
        hashtags = item.attrs[:entities][:hashtags].map {|tag| tag[:text].downcase}.uniq

        @@hashtags_all << hashtags

        # Create a new TweetTopic row for each hashtag
        hashtags.each do |hashtag|
          TweetTopic.create(
            tweet_id: Tweet.find_by(tweet_code: item.id).id,
            topic_id: Topic.find_by(name: hashtag).id
          )
        end
      end
    end
  end

  def pull_data(term)
    #downcase the term
    term = term.downcase

    # Call the Twitter API via Twitter Gem and store response
    response = client.search("##{term}", count: 10)
    binding.pry

    # Create our first topic while we have the search term
    Topic.create(name: term)

    # Call the methods to make our data
    pull_user_data(response)
    pull_tweet_data(response)
    pull_topic_data(response)
    create_tweet_topic_relationship(response, term)
  end

  def self.run(term)
    tweet_client = TwitterApi.new
    tweet_client.pull_data("##{term}")
  end

end
