require_relative "blackjack"
require "pry"

player = Player.new
dealer = Dealer.new

blackjack = Blackjack.new(player, dealer)

blackjack.start
