require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/card_generator'
require './lib/alt_card_generator'

class War
  attr_reader :full_deck, :turn, :turn_counter

  def initialize
    @full_deck = CardGenerator.new("./lib/cards.txt").cards
    shuffled_deck = @full_deck.shuffle.each_slice(@full_deck.length / 2).to_a
    deck_1 = Deck.new(shuffled_deck[0])
    deck_2 = Deck.new(shuffled_deck[1])
    player_1 = Player.new("Geordie", deck_1)
    player_2 = Player.new("Riker", deck_2)
    @turn = Turn.new(player_1, player_2)
    @turn_counter = 0
  end

  def create_full_deck_without_text_file
    @full_deck = AltCardGenerator.new.cards
  end

  def show_prompt
    puts "Welcome to War! (or Peace) This game will be played with #{@full_deck.length} cards."
    puts "The players today are #{@turn.player1.name} and #{@turn.player2.name}."
    puts "Type 'GO' to start the game!"
    puts "------------------------------------------------------"
    input = gets.chomp
    if input.upcase == "GO"
      puts "The game begins!"
    else
      abort "Okay bye!"
    end
  end

  def run_game_loop
    until @turn.player1.has_lost? || @turn.player2.has_lost?
      @turn_counter += 1
      @turn.type
      @turn.determine_winner
      @turn.pile_cards
      puts "Turn #{@turn_counter} : #{@turn.display_type} #{@turn.show_cards_won}"
      @turn.award_spoils(@turn.winner)

      break if @turn_counter == 1000000
    end
  end

  def show_winner
    if @turn.player1.has_lost? || @turn.player2.has_lost?
      puts "*~*~*~* #{@turn.winner.name} has won the game! *~*~*~*"
    else
      puts "---- DRAW ----"
    end
  end

  def set_counter(number)
    @turn_counter = number
  end

  def start
    show_prompt
    run_game_loop
    show_winner
  end

end
