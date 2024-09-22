# frozen_string_literal: true

# Game class and main gameplay
require_relative 'lib/controller'

def instructions
  puts "Welcome to Mastermind!\n"
  puts
  puts 'You can be either the codemaker or codebreaker:'
  puts
  puts 'CodeMaker: You set a code for the computer to guess.'
  puts "CodeBreaker: You must break the code.\n"
  puts
  puts "There are hints along the way so be on the lookout.\n"
  puts
  puts 'The objective is to guess the code in the fewest guesses.'
  puts
  puts "You win if you either crack the computer's code OR if you stump the computer with a code of your own!\n"
  puts
  puts 'Good luck!!'
  puts
end

instructions
Controller.new
Controller.new.play
