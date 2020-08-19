require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

card1 = Card.new(:diamond, "2", 2)
card2 = Card.new(:heart, "2", 2)
card3 = Card.new(:club, "2", 2)
card4 = Card.new(:spade, "2", 2)
card5 = Card.new(:diamond, "3", 3)
card6 = Card.new(:club, "3", 3)
card7 = Card.new(:heart, "3", 3)
card8 = Card.new(:spade, "3", 3)
card9 = Card.new(:diamond, "4", 4)
card10 = Card.new(:club, "4", 4)
card11 = Card.new(:heart, "4", 4)
card12 = Card.new(:spade, "4", 4)
card13 = Card.new(:diamond, "5", 5)
card14 = Card.new(:club, "5", 5)
card15 = Card.new(:heart, "5", 5)
card16 = Card.new(:spade, "5", 5)
card17 = Card.new(:diamond, "6", 6)
card18 = Card.new(:club, "6", 6)
card19 = Card.new(:heart, "6", 6)
card20 = Card.new(:spade, "6", 6)
card21 = Card.new(:diamond, "7", 7)
card22 = Card.new(:club, "7", 7)
card23 = Card.new(:heart, "7", 7)
card24 = Card.new(:spade, "7", 7)
card25 = Card.new(:diamond, "8", 8)
card26 = Card.new(:club, "8", 8)
card27 = Card.new(:heart, "8", 8)
card28 = Card.new(:spade, "8", 8)
card29 = Card.new(:diamond, "9", 9)
card30 = Card.new(:club, "9", 9)
card31 = Card.new(:heart, "9", 9)
card32 = Card.new(:spade, "9", 9)
card33 = Card.new(:diamond, "10", 10)
card34 = Card.new(:club, "10", 10)
card35 = Card.new(:heart, "10", 10)
card36 = Card.new(:spade, "10", 10)
card37 = Card.new(:diamond, "Jack", 11)
card38 = Card.new(:club, "Jack", 11)
card39 = Card.new(:heart, "Jack", 11)
card40 = Card.new(:spade, "Jack", 11)
card41 = Card.new(:diamond, "Queen", 12)
card42 = Card.new(:club, "Queen", 12)
card43 = Card.new(:heart, "Queen", 12)
card44 = Card.new(:spade, "Queen", 12)
card45 = Card.new(:diamond, "King", 13)
card46 = Card.new(:club, "King", 13)
card47 = Card.new(:heart, "King", 13)
card48 = Card.new(:spade, "King", 13)
card49 = Card.new(:diamond, "Ace", 14)
card50 = Card.new(:club, "Ace", 14)
card51 = Card.new(:heart, "Ace", 14)
card52 = Card.new(:spade, "Ace", 14)

full_deck = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11,
card12, card13, card14, card15, card16, card17, card18, card19, card20, card21, card22,
card23, card24, card25, card26, card27, card28, card29, card30, card31, card32, card33,
card34, card35, card36, card37, card38, card39, card40, card41, card42, card43, card44,
card45, card46, card47, card48, card49, card50]

shuffled_deck = full_deck.shuffle.each_slice(full_deck.length / 2).to_a
deck_1 = Deck.new(shuffled_deck[0])
deck_2 = Deck.new(shuffled_deck[1])

player_1 = Player.new("Geordie", deck_1)
player_2 = Player.new("Riker", deck_2)

turn = Turn.new(player_1, player_2)

puts "Welcome to War! (or Peace) This game will be played with #{full_deck.length} cards."
puts "The players today are #{turn.player1.name} and #{turn.player2.name}."
puts "Type 'GO' to start the game!"
puts "------------------------------------------------------"
turn.start

turn_counter = 0
until turn.player1.has_lost? || turn.player2.has_lost?
  turn.type
  turn.determine_winner
  turn.pile_cards
  puts "Turn #{turn_counter} : #{turn.turn_type} #{turn.winner.name} won #{turn.spoils_of_war.length} cards."
  turn.award_spoils(turn.winner)

  turn_counter += 1
  break if turn_counter == 1000000
end