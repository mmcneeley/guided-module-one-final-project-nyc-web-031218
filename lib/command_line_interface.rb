class CommandLineInterface

  @topic = ""

  def greet
    puts "\n"
    puts "Hello, welcome to the Twitter query tool     ".upcase
    puts "============================================="

  end

  def new_topic
    puts "\n"
    puts "Enter a topic to analyze Twitter's data:"
    print "> "
    @topic = gets.strip
    puts "\n"
    if @topic != ""
      puts "Cool, we'll start looking for tweets about #{@topic.upcase}. Hang tight!"
      topic_commands
    else
      new_topic
    end
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
    if @topic == ""
      new_topic
    else
      puts "The current topic is: #{@topic}.".upcase
    end
    puts " 1. See the most popular (favorited) tweet about #{@topic}"
    puts " 2. See the most popular person tweeting about #{@topic}"
    puts " 3. Check the number of unique tweets about #{@topic}"
    puts " 4. Get the total number of users tweeting about #{@topic}"
    print "> "
    response = gets.chomp
    
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
          break;
        else
          puts "Not a valid response. Type 'help' for a list of commands."
        end
      response = ""
    end
  end

end

cli = CommandLineInterface.new
cli.greet
cli.run
