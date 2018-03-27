class Topic < ActiveRecord::Base
  has_many :tweets through: :tweet_topics
end
