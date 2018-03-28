class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :screen_name
      t.string :name
      t.integer :followers_count
      t.integer :friends_count
      t.string :timezone
      t.integer :statuses_count
      t.string :profile_image_url
      t.integer :user_code
    end
  end
end
