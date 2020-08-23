require './test/test_helper'

class WarTest < Minitest::Test
  def setup
    @war = War.new
  end

  def test_it_exists
    assert_instance_of War, @war
  end

  def test_it_has_a_full_deck
    assert_equal 52, @war.full_deck.length
    @war.full_deck.each {|card| assert_instance_of Card, card}
  end

  def test_can_create_deck_with_alternate_generator
    @war.create_full_deck_without_text_file
    assert_equal 52, @war.full_deck.length
    @war.full_deck.each {|card| assert_instance_of Card, card}
  end

  def test_can_split_and_shuffle_decks
    refute_equal @war.full_deck[0..25], @war.turn.player1.deck.cards
    refute_equal @war.full_deck[26..51], @war.turn.player2.deck.cards
  end

  def test_can_create_fully_functional_turn
    assert_instance_of Turn, @war.turn
    assert_instance_of Player, @war.turn.player1
    assert_instance_of Player, @war.turn.player2
    assert_instance_of Deck, @war.turn.player1.deck
    assert_instance_of Deck, @war.turn.player2.deck
  end

  def test_no_two_decks_are_the_same
    war_2 = War.new
    refute_equal war_2.turn.player1.deck.cards, @war.turn.player1.deck.cards
    refute_equal war_2.turn.player2.deck.cards, @war.turn.player2.deck.cards
  end

  def test_can_show_winner
    assert_output(/---- DRAW ----/) { @war.show_winner }
    @war.turn.player2.deck.cards.clear
    @war.turn.type
    @war.turn.determine_winner
    assert_output("*~*~*~* Geordie has won the game! *~*~*~*\n") {@war.show_winner}
  end

  def test_game_loop
    card1 = Card.new(:heart, "2", 2)
    card2 = Card.new(:diamond, "10", 10)
    @war.turn.player2.deck.cards.clear
    @war.turn.player1.deck.cards.clear
    @war.turn.player1.deck.add_card(card1)
    @war.turn.player2.deck.add_card(card2)
    assert_output("Turn 1 :  Riker won 2 cards\n") { @war.run_game_loop }
    assert_equal 1, @war.turn_counter
    assert_equal "Riker", @war.turn.winner.name
    assert @war.turn.player1.has_lost?
  end

  def test_show_prompt
    user_input = StringIO.new
    user_input.puts "go"
    user_input.rewind
    $stdin = user_input
    expected = "Welcome to War! (or Peace) This game will be played with 52 cards.\nThe players today are Geordie and Riker.\nType 'GO' to start the game!\n------------------------------------------------------\nThe game begins!\n"

    assert_output(expected) { @war.show_prompt }
  end

end
