
class Topic < ActiveRecord::Base
  has_many :tweet_topics
  has_many :tweets, through: :tweet_topics

  def self.most_retweeted_by_topic
    retweet_number = Tweet.find_by(retweet_count: Tweet.maximum(:retweet_count)).retweet_count
    tweet_content = Tweet.find_by(retweet_count: Tweet.maximum(:retweet_count)).text
    return "#{tweet_content}\n Retweeted #{retweet_number} times"
  end

  def self.most_favorited_by_topic
    favorited_number = Tweet.find_by(favorite_count: Tweet.maximum(:favorite_count)).favorite_count
    tweet_content = Tweet.find_by(favorite_count: Tweet.maximum(:favorite_count)).text
    return "#{tweet_content}\n Favorited #{favorited_number} times"
  end

  def self.most_popular_user_by_topic
    User.find_by(followers_count: User.maximum(:followers_count)).name
  end

  def self.total_tweets_for_topic(user_input = "superbowl")
    Topic.find_by(name: "#{user_input}").tweets.count
  end

  def self.total_users_for_topic(user_input = "superbowl")
    Topic.find_by(name: "#{user_input}").tweets.collect { |tweet| User.find_by(id: tweet.user_id) }.count
  end

#---------------------------------------------------------------------------------------------------------------

  # Number of languages this topic has been tweeted about in
  # Thirsy Users --- Users that follow a lot more people then follow them "followers_count" - "friends_count"
  # What timezone is a tweet most popular in.

  # def top_3_langs_tweeting
  #   Tweet.group("lang").count
  #
  # end


end
