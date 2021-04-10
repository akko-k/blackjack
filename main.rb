require "./blackjack"
require "./Player"

player_money = Blackjack.request_player_to_enter_money

player = Player.new(player_money)
dealer = Dealer.new

blackjack = Blackjack.new(player,dealer)

blackjack.start(player_money)