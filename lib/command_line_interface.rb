class CommandLineInterface

  @topic = ""

  def greet
    puts "\n"
    puts "Hello, welcome to the Twitter query tool     ".upcase
    puts "========================================="
  end

  def new_topic
    puts "\n"
    puts "Enter a topic to analyze Twitter's data:"
    print "> "
    @topic = gets.strip
    puts "\n"
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
    loop do
      puts "\n"
      if @topic == ""
        new_topic
      else
        puts "Here's a list of commands you can run on: #{@topic.upcase}."
      end
      puts "- loved : the most favorited tweet about #{@topic}"
      puts "- retweeted : the most retweet about #{@topic}"
      puts "- celeb : the most popular person tweeting about #{@topic}"
      puts "- total tweets : number of tweets about #{@topic}"
      puts "- total users : number of users tweeting about #{@topic}"
      puts "- new topic : search for a new topic"
      puts "- exit : go back to the main menu"
      print "> "
      response = gets.chomp
      case response
        when "loved"
          puts Topic.most_favorited_by_topic
        when "retweeted"
          puts Topic.most_retweeted_by_topic
        when "celeb"
          puts Topic.most_popular_user_by_topic
        when "total tweets"
          puts Topic.total_tweets_for_topic
        when "total users"
          puts Topic.total_users_for_topic
        when "new topic"
          new_topic
        when "exit"
          run
        else
          puts "sending you back to the main menu"
          run
      end
    end
  end

  def exit
    puts "We're sad to see you go! Exiting..."
    abort
  end

  def run
    program_commands
    loop do
      puts "Please enter a command:"
      print "> "
      response = gets.chomp
        if response.downcase == "topic"
          new_topic
        elsif response.downcase == "help"
          program_commands
        elsif response.downcase == "exit"
          exit
        else
          puts "Not a valid response. Type 'help' for a list of commands."
          puts "\n"
        end
      response = ""
    end
  end

end
