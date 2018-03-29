require 'colorize'
require 'colorized_string'

class CommandLineInterface

  @topic = ""

  def greet
    puts "\n"
    puts "///////////////////////////////////////////////////////////////////////////////////////////".colorize(:light_cyan)
    puts "//////////////////////////////////////////////////////////////////////////////:..-/////////".colorize(:light_cyan)
    puts "////-``://///////////////////-``::``:////-``:///////////////////////:..-:////.   `.-///////".colorize(:light_cyan)
    puts "////.  -///////:////::////://:../.  .////.  .///////::://////////////.   `.:.       .//////".colorize(:light_cyan)
    puts "////.       `/` .//:  -//. `/.  :.     `:.     `:/.``````-//-``   `///.              `-////".colorize(:light_cyan)
    puts "////.  .:::::/  `//-  .//.  :`  -.  .:::/.  .:::/`  `.`   :.  .::::///:-            `::////".colorize(:light_cyan)
    puts "////-  `-----/`  --`  `--  `/`  --  `---:-  `---:.  `....-/`  //////////.          .///////".colorize(:light_cyan)
    puts "/////:.``````:/.````..````.:/-``:/:.````./:.````./-```````/-``////:-..``        `.:////////".colorize(:light_cyan)
    puts "/////////////////////////////////////////////////////////////////////:-......--:///////////".colorize(:light_cyan)
    puts "///////////////////////////////////////////////////////////////////////////////////////////".colorize(:light_cyan)
    puts "\n"
    puts "Hello, welcome to the Tweet Topic Analysis Tool".upcase.colorize(:light_cyan).bold
  end

  def new_topic
    puts "\n"
    puts "Enter a topic (e.g. beyonce) to find and analyze tweets:".colorize(:light_cyan)
    print "> "
    @topic = gets.strip
    puts "\n"
    if @topic == "exit"
      exit
    elsif @topic == "clear"
      clear
    elsif @topic == "stats"
      return stats
    end
    TwitterApi.run(@topic)
    topic_commands
  end

  def program_commands
    puts "\n"
    puts "- topic : to search for tweets about a topic".colorize(:light_cyan)
    puts "- help : to see the available commands for this program".colorize(:light_cyan)
    puts "- exit : to leave the program".colorize(:light_cyan)
    puts "\n"
  end

  def topic_commands
    @topic = @topic.downcase
    loop do
      puts "Commands for the topic '#{@topic}'".upcase.colorize(:light_cyan).bold
      puts "loved          =>    the most favorited tweet".colorize(:light_cyan)
      puts "retweeted      =>    the most retweet".colorize(:light_cyan)
      puts "celeb          =>    the most popular person tweeting".colorize(:light_cyan)
      puts "total tweets   =>    number of tweets".colorize(:light_cyan)
      puts "total users    =>    number of users tweeting".colorize(:light_cyan)
      puts "new topic      =>    change the topic".colorize(:light_cyan)
      puts "stats          =>    to see the total database counts".colorize(:light_cyan)
      puts "exit           =>    quit the program".colorize(:light_cyan)
      puts "\n"
      print "> "
      response = gets.chomp
      case response
        when "loved"
          puts "\n"
          puts "MOST FAVORITED".colorize(:white).bold.underline
          puts Topic.most_favorited_by_topic(@topic)
          puts "\n"
        when "retweeted"
          puts "\n"
          puts "MOST RETWEETED".colorize(:white).bold.underline
          puts Topic.most_retweeted_by_topic(@topic)
          puts "\n"
        when "celeb"
          puts "\n"
          puts "MOST FOLLOWERS".colorize(:white).bold.underline
          puts Topic.most_popular_user_by_topic(@topic)
          puts "\n"
        when "total tweets"
          puts "\n"
          puts "TOTAL TWEETS".colorize(:white).bold.underline
          puts Topic.total_tweets_for_topic(@topic)
          puts "\n"
        when "total users"
          puts "\n"
          puts "TOTAL USERS".colorize(:white).bold.underline
          puts Topic.total_users_for_topic(@topic)
          puts "\n"
        when "new topic"
          clear
        when "stats"
          stats
        when "exit"
          exit
        else
          puts "Not a valid command. Please try again.".colorize(:white)
          puts "\n"
      end
    end
  end

  def clear
    Tweet.destroy_all
    User.destroy_all
    TweetTopic.destroy_all
    Topic.destroy_all
    new_topic
  end

  def stats
    puts "\n"
    puts "NUMBER OF USERS".colorize(:white).bold.underline
    puts User.all.count

    puts "NUMBER OF TWEETS".colorize(:white).bold.underline
    puts Tweet.all.count

    puts "NUMBER OF RELATED HASHTAG TOPICS".colorize(:white).bold.underline
    puts Topic.all.count
    puts "\n"
    if @topic == "" || @topic == "stats"
      new_topic
    end
  end

  def exit
    puts "\n"
    puts "We're sad to see you go! Exiting...".colorize(:light_cyan)
    puts "\n"
    abort
  end

  def run
    new_topic
  end

end
