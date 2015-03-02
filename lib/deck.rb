require_relative 'card'

class IllegalDeckRequest < StandardError
end

# Represents a deck of playing cards.
class Deck

  def initialize(cards)
    @cards = cards
  end

  # Returns an array of all 52 playing cards shuffled.
  def self.new_game_deck
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle!

  end

  #
  # # Returns the number of cards in the deck.
  # def count
  #   @cards.count
  # end
  #
  # # Takes `n` cards from the top of the deck.
  # def take(n)
  #   raise IllegalDeckRequest.new "Requested too many cards." if count < n
  #   out    = @cards.take(n)
  #   @cards = @cards.drop(n)
  #   out
  # end
  #
  # # Returns an array of cards to the bottom of the deck.
  # def return(cards)
  #   @cards += cards
  # end
end


