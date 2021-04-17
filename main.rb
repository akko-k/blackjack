require "./blackjack"
require "./Player"
require "pry"


player_money = Blackjack.request_player_to_check_money

player = Player.new(player_money)
dealer = Dealer.new

blackjack = Blackjack.new(player,dealer)

blackjack.start