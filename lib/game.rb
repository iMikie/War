require_relative 'player'
require_relative 'hand'


class QuitGameError < StandardError
end
class OutOfCardsError < StandardError
end

class Game

  def initialize
    puts "Welcome to WAR!"
    @game_over     = false
    @player1       = HumanPlayer.new
    @player2       = RobotPlayer.new
    @cards_in_play = Array.new(2){ Array.new}
    puts "#{@player1.name} is playing #{@player2.name}"
    puts "  To play a card face up type 'C'. Face down: 'c'."
    puts "  To quit at anytime type 'q'."
    puts ""

  end


  def play
    begin
      @deck         = Deck.new_game_deck
      @player1.hand = Hand.new(@deck.shift(26))
      @player2.hand = Hand.new(@deck.shift(26))


      loop do
        get_cards_from_players(1)
        puts "Cards are: #{@player1.name}: #{@cards_in_play[0][-1]} and #{@player2.name}: #{@cards_in_play[1][-1]}"
        play_turn
      end

    rescue OutOfCardsError => e
      winner = (e.message == player1.name ? player2.name : player1.name)
      puts "Congratulations player #{winner}"
      puts "Would you like to play again: y/n ?"
      raise QuitGameError if gets.chomp == 'n'
      retry
    rescue QuitGameError
      @game_over = true
      puts "Thanks for playing."
    rescue IllegalDeckRequest => e
      puts e.message

    end
  end

  def prompt_players(message)
    @player1.prompt(message)
    @player2.prompt(message)
  end


  def play_turn

    player1points = @cards_in_play[0].last.points
    player2points = @cards_in_play[1].last.points

    if player1points == player2points
      play_war
    elsif player1points > player2points
      cards_to_winner(@player1)
      prompt_players("Round to #{@player1.name}")
    else
      cards_to_winner(@player2)
      prompt_players("Round to #{@player2.name}")
    end

  end

  def get_cards_from_players(number)cd W
    [@player1, @player2].each_with_index do |player, index|
      @cards_in_play[index] += player.play_cards(number)
    end

  end

  def play_war
    puts "WAR is DECLARED!"
    puts ""

    get_cards_from_players(4)
    puts "Cards are: #{@player1.name}: xxx#{@cards_in_play[0][-1]} and #{@player2.name}: xxx#{@cards_in_play[1][-1]}"

    play_turn

  end

  def cards_to_winner(winner)
    winner.hand.receive_cards(@cards_in_play.flatten)
  end


end

