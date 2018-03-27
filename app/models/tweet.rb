class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :tweet_topics
  has_many :topics, through: :tweet_topics
end
