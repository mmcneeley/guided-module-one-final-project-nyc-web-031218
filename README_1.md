# Tweet Topic Analysis Tool

This command line application helps you pull interesting data from tweets grouped by a chosen topic.

## Getting Started

Fork and clone this github repository down onto your local machine. In your command line type '$ ruby bin/run.rb' to launch the Tweet Topic Analysis Tool application.

### Prerequisites

Make sure to run bundle install in the command line in order to install all required gems and dependencies.
```
$ bundle instal
```

### Installing

Once you have cloned the project down, bundle install all dependencies and have opened the application with the command ‘$ ruby bin/run.rb’ you should be greeted by Tweet Topic Analysis Tool    


## How does it work?

1. The program asks the user for a topic they'd like to learn more about.
2. The app then pulls data from Twitter's API matching the user's search input.
3. The user will then be presented with a number of option on how they would like to search their topic      results
4. The user can enter "help", "data" or "clear"
5. The user is able to input a new search term at any point clearing the database and starting fresh with their new topic.

## Built With

* [TwitterApi](https://developer.twitter.com/en/docs) - Pull data from Twitter API
* [Twitter Gem](https://github.com/sferik/twitter/) - Interact with twitter api
* [Colorize Gem](https://rubygems.org/gems/colorize/versions/0.7.5) - Customize CLI output

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors Mike McNeeley

* **Mike McNeeley**
* **Gregory Dwyer**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Flatiron School
* etc
