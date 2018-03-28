require_relative '../config/environment'
require 'pry'

cli = CommandLineInterface.new
cli.greet
cli.run
