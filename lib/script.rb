require_relative 'player'
require_relative 'controller'

# Scripts of the game
class Script
  attr_accessor :choice

  def welcome
    puts
    puts 'Do you want to:'
    puts '1. Break the code?'
    puts '2. Make the code?'
    puts
    print 'Make your choice: '
    @choice = gets.chomp.to_i
  end

  def invalid_game_mode
    puts 'Invalid choice'
    puts 'Please choose option 1 or option 2.'
  end

  def invalid_color
    puts "Invalid Color. Please chose from #{Computer::COLORS}"
  end

  def color_choices
    puts "Colors to choose from: #{Controller::COLORS}"
    puts 'Please enter your guess for the four color code:'
  end

  def end_game
    puts
    puts 'Thanks for playing Mastermind!'
    puts 'Created by Xebros - 2024'
    puts
  end

  def play_again?
    loop do
      print 'Do you want to play again? (y/n): '
      input = gets.chomp.downcase

      case input
      when 'y'
        system 'clear'
        load './main.rb'
        return true
      when 'n'
        end_game
        exit
      else
        print "Invalid input. Please enter either 'y' or 'n'.\n\n"
      end
    end
  end

  def guess_script
    puts "Colors to choose from: #{Controller::COLORS.inspect}"
    print "Please enter your guess for the secret color code:\n"
  end

  def player_win
    puts 'You have won!'
    puts "You are a true Mastermind!\n"
    puts
    play_again?
  end

  def computer_win
    puts 'The computer has cracked your code!'
    puts "Better luck next time!\n"
    puts
    play_again?
  end

  def player_lose
    puts 'Sorry! You have lost!'
    puts "Better luck next time!\n"
    puts
    play_again?
  end

  def computer_thinking
    puts "\nThe computer is making its guess"
    3.times do
      print '.'
      sleep(0.5)
    end
  end

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
end
