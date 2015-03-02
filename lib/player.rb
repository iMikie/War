require_relative 'hand'

class PlayerError < StandardError
end


class Player
  attr_reader :name
  attr_accessor :hand

  def initialize
  end

  def play_cards(number_of_cards)
    raise OutOfCardsError.new "name" if hand.count < number_of_cards
    @hand.take(number_of_cards)
  end

end

class HumanPlayer < Player

  def prompt(message)
    puts message
  end

  def play_cards(number_of_cards)
    if number_of_cards == 1
      puts "Play a card, (e.g. 'C'): "
    else
      puts "Play three cards down and one up e.g. cccC: "
    end

    input = gets.chomp
    raise QuitGameError.new if input[0] == 'q'
    raise OutOfCardsError.new "name" if hand.count < number_of_cards

    @hand.take(number_of_cards)
  end


  def initialize
    puts "What is your name?"
    @name = gets.chomp
  end

end

class RobotPlayer < Player
  def initialize
    @name = "GORT"
  end

  def play_cards(number_of_cards)
    raise OutOfCardsError.new "name" if hand.count < number_of_cards
    @hand.take(number_of_cards)
  end


  def prompt(message)
  end
end