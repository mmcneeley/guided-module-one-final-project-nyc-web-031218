require 'twitter'
require 'yaml'
require 'pry'


class TwitterApi
  attr_reader :client

  def initialize
    keys = YAML.load_file('application.yml')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = keys['CONSUMER_KEY']
      config.consumer_secret     = keys['CONSUMER_SECRET']
      config.access_token        = keys['ACCESS_TOKEN']
      config.access_token_secret = keys['ACCESS_TOKEN_SECRET']
    end
  end


  def pull_user_data(data)

    data.each do |item|
      User.all.where(user_code: item.user.id).exists? ? next : User.create(screen_name: item.user.screen_name, name: item.user.name, followers_count: item.user.followers_count, friends_count: item.user.friends_count, timezone: item.user.time_zone, statuses_count: item.user.statuses_count, profile_image_url: item.user.profile_image_url, user_code: item.user.id)
    end

    end

  def pull_tweet_data(data)

    data.each do |item|
      Tweet.create(user_id: (User.find_by(screen_name: item.user.screen_name).id), text: item.text, creation_time: item.created_at, favorite_count: item.favorite_count, retweet_count: item.retweet_count, lang: item.lang, tweet_code: item.id)
    end

  end

  def pull_topic_data(data)
    data.each do |item|

      # if item.attrs[:entities][:hashtags].count == 0
      #   next
      # else
        item.attrs[:entities][:hashtags].each do |tag|

          Topic.all.where(name: tag[:text]).exists? ? next : Topic.create(name: tag[:text])
      # end
      end
    end
  end

  def create_tweet_topic_relationship(data)
    data.each do |item|
      current_tag = ""

      if item.attrs[:entities][:hashtags].count == 0
        next
      else
        item.attrs[:entities][:hashtags].each do |tag|
          current_tag = tag[:text]

          TweetTopic.all.where(tweet_id: (Tweet.find_by(text: item.text).id), topic_id: (Topic.find_by(name: current_tag).id)).exists? ? next : TweetTopic.create(tweet_id: (Tweet.find_by(text: item.text).id), topic_id: (Topic.find_by(name: current_tag).id))
        end
      end
    end
  end



  def pull_data(term)
    response = client.search("##{term}", count: 100)

    pull_user_data(response)
    pull_tweet_data(response)
    pull_topic_data(response)
    create_tweet_topic_relationship(response)

  end

  def self.run(term)
    tweet_client = TwitterApi.new
    tweet_client.pull_data("##{term}")
  end

end
