class HandError < StandardError
end
class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def receive_cards(cards)
    @cards << cards
  end

  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    @cards.shift(n)
  end

end

