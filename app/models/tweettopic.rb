class TweetTopic < ActiveRecord::Base
  belongs_to :tweets
  belongs_to :topics
end
