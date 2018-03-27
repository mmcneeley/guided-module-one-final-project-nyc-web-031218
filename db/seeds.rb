# topic_term = #superbowl

#ACCESS THE TWITTER API // CREDS // YAML
# response = client.adksmfkasdmfklamsdkfmaksdmfkamfdl

# ===============

# #Users
# greg = User.create(screen_name: "gjdwyer", name: "Greg", followers: 350)
# mike = User.create(screen_name: "mikemcneeley", name: "Mike", followers: 240)
# sarah= User.create(screen_name: "Sara87", name: "Sarah", followers: 10)

response.each do |item|
  User.create(screen_name: item.user.screen_name, name: item.user.name, followers: item.user.followers_count)
end

#Tweets
tweet1 = Tweet.create(user_id: greg.id, text: "Af taxidermy glossier, hexagon poke fanny pack tilde bicycle rights. #superbowl", creation_time: Time.now)
tweet2 = Tweet.create(user_id: mike.id, text: "Stumptown occupy blue bottle, mustache vegan portland lo-fi authentic. #coffee", creation_time: Time.now)
tweet3 = Tweet.create(user_id: sarah.id, text: "Street art single-origin coffee helvetica live-edge ramps pabst crucifix readymade blue bottle flannel. #superbowl", creation_time: Time.now)
tweet4 = Tweet.create(user_id: mike.id, text: "Lorem ipsum dolor amet keffiyeh drinking vinegar banjo poutine vinyl la croix chia whatever mustache waistcoat YOLO. #coffee", creation_time: Time.now)

# response.each do |item|
#   Tweet.create(user_id: (User.find_by(screen_name: item.user.screen_name).id), text: item.text, creation_time: item.created_at)
# end

#Topics
superbowl = Topic.create(name: "#superbowl")
# coffee = Topic.create(name: "#coffee")

#TweetTopics
tt1 = TweetTopic.create(tweet_id: tweet1.id, topic_id: superbowl.id)
tt2 = TweetTopic.create(tweet_id: tweet2.id, topic_id: coffee.id)
tt3 = TweetTopic.create(tweet_id: tweet3.id, topic_id: superbowl.id)
tt4 = TweetTopic.create(tweet_id: tweet4.id, topic_id: coffee.id)

# response.each do |item|
#   TweetTopic.create(tweet_id: (Tweet.find_by(text: item.text).id), topic_id: superbowl.id)
# end
