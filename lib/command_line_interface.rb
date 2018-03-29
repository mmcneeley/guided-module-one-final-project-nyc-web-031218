class CommandLineInterface

  @topic = ""

  def greet
    puts "\n"
    puts "///////////////////////////////////////////////////////////////////////////////////////////"
    puts "//////////////////////////////////////////////////////////////////////////////:..-/////////"
    puts "////-``://///////////////////-``::``:////-``:///////////////////////:..-:////.   `.-///////"
    puts "////.  -///////:////::////://:../.  .////.  .///////::://////////////.   `.:.       .//////"
    puts "////.       `/` .//:  -//. `/.  :.     `:.     `:/.``````-//-``   `///.              `-////"
    puts "////.  .:::::/  `//-  .//.  :`  -.  .:::/.  .:::/`  `.`   :.  .::::///:-            `::////"
    puts "////-  `-----/`  --`  `--  `/`  --  `---:-  `---:.  `....-/`  //////////.          .///////"
    puts "/////:.``````:/.````..````.:/-``:/:.````./:.````./-```````/-``////:-..``        `.:////////"
    puts "/////////////////////////////////////////////////////////////////////:-......--:///////////"
    puts "///////////////////////////////////////////////////////////////////////////////////////////"
    puts "\n"
    puts "Hello, welcome to the Twitter query tool".upcase
  end

  def new_topic
    puts "\n"
    puts "Enter a topic (e.g. beyonce) to find and analyze tweets:"
    print "> "
    @topic = gets.strip
    puts "\n"
    TwitterApi.run(@topic)
    topic_commands
    puts "\n"
  end

  def program_commands
    puts "\n"
    puts "- topic : to search for tweets about a topic"
    puts "- help : to see the available commands for this program"
    puts "- exit : to leave the program"
    puts "\n"
  end

  def topic_commands
    @topic = @topic.downcase
    loop do
      puts "Available commands on the topic: #{@topic.upcase}."
      puts "- loved : the most favorited tweet"
      puts "- retweeted : the most retweet"
      puts "- celeb : the most popular person tweeting"
      puts "- total tweets : number of tweets"
      puts "- total users : number of users tweeting"
      puts "- new topic : change the topic"
      puts "- data : to see the total database counts"
      puts "- exit : quit the program"
      puts "\n"
      print "> "
      response = gets.chomp
      case response
        when "loved"
          Topic.most_favorited_by_topic(@topic)
        when "retweeted"
          Topic.most_retweeted_by_topic(@topic)
        when "celeb"
          Topic.most_popular_user_by_topic(@topic)
        when "total tweets"
          Topic.total_tweets_for_topic(@topic)
        when "total users"
          Topic.total_users_for_topic(@topic)
        when "new topic"
          new_topic
        when "data"
          puts "\n"
          puts "NUMBER OF USERS"
          puts User.all.count

          puts "NUMBER OF TWEETS"
          puts Tweet.all.count

          puts "NUMBER OF RELATED HASHTAG TOPICS"
          puts Topic.all.count
          puts "\n"
        when "exit"
          exit
        else
          puts "\n"
          puts "Not a valid command. Please try again."
          puts "\n"
      end
    end
  end

  def exit
    puts "\n"
    puts "We're sad to see you go! Exiting..."
    puts "\n"
    abort
  end

  def run
    new_topic
  end

end
