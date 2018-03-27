class CreateTweetTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_topics do |t|
      t.integer :tweet_id
      t.integer :topic_id
    end
  end
end
