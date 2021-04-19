require_relative "character.rb"
class Player < Character
  attr_reader :money, :bet

  def self.check_money
    money = gets.to_i
  end

  def initialize(player_money)
    @money = player_money
    @hand = []
  end

  def bet_money(bet)
    @money -= bet
  end

  def show_hand

    puts <<~text

          ------------#{self.class} 手札------------
          text
    @hand.each.with_index(1) do |card, i|
      puts " #{i}枚目 ： #{card.card_info}"
    end
    puts "-----------------------------------"
  end

  def select_hit_or_stand
    select_action_num = gets.chomp.to_i
  end
end