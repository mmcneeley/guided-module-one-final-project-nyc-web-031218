
class Topic < ActiveRecord::Base
  has_many :tweet_topics
  has_many :tweets, through: :tweet_topics

  def self.most_retweeted_by_topic(user_input = "")
    user_screen_name = Tweet.find_by(retweet_count: Tweet.maximum(:retweet_count)).user.screen_name
    retweet_number = Tweet.find_by(retweet_count: Tweet.maximum(:retweet_count)).retweet_count
    tweet_content = Tweet.find_by(retweet_count: Tweet.maximum(:retweet_count)).text
    return "@#{user_screen_name}\n'#{tweet_content}'\n\nRETWEETED: #{retweet_number} times"
  end

  def self.most_favorited_by_topic(user_input = "")
    favorited_name = Tweet.find_by(favorite_count: Tweet.maximum(:favorite_count)).user.name
    favorited_number = Tweet.find_by(favorite_count: Tweet.maximum(:favorite_count)).favorite_count
    tweet_content = Tweet.find_by(favorite_count: Tweet.maximum(:favorite_count)).text
    return "@#{favorited_name}\n'#{tweet_content}'\n\nFAVORITED: #{favorited_number} times"
  end

  def self.most_popular_user_by_topic(user_input = "")
    user_screen_name = User.find_by(followers_count: User.maximum(:followers_count)).screen_name
    mad_followers = User.find_by(followers_count: User.maximum(:followers_count)).followers_count
    return "@#{user_screen_name} is the twitter celeberty talking about ##{user_input} with #{mad_followers} followers"
  end

  def self.total_tweets_for_topic(user_input = "")
    tweets_count = Topic.find_by(name: "#{user_input}").tweets.count
    return "There are #{tweets_count} recent tweets for ##{user_input}"
  end

  def self.total_users_for_topic(user_input = "")
    user_count = Topic.find_by(name: "#{user_input}").tweets.collect { |tweet| User.find_by(id: tweet.user_id) }.count
    return "There are #{user_count} people tweeting about the topic ##{user_input}"
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
