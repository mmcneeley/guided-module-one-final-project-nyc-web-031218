
class Topic < ActiveRecord::Base
  has_many :tweet_topics
  has_many :tweets, through: :tweet_topics

  def self.most_retweeted_by_topic
    Tweet.find_by(retweet_count: Tweet.maximum(:retweet_count))
  end

  def self.most_favorited_by_topic
    Tweet.find_by(retweet_count: Tweet.maximum(:retweet_count))
  end

  def self.most_popular_user_by_topic
    User.find_by(followers_count: User.maximum(:followers_count))
  end

  def self.total_tweets_for_topic(user_input = "superbowl")
    Topic.find_by(name: "#{user_input}").tweets.count
  end

  def self.total_users_for_topic(user_input = "superbowl")
    Topic.find_by(name: "#{user_input}").tweets.collect { |tweet| User.find_by(id: tweet.user_id) }.count
  end

end
