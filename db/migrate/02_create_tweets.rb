class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.text :text
      t.datetime :creation_time
      t.integer :favorite_count
      t.integer :retweet_count
      t.string :lang
      t.bigint :tweet_code
      t.text :hashtags
    end
  end
end
