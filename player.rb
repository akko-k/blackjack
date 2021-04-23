require_relative "character.rb"

class Player < Character
  attr_reader :money, :bet, :loss, :win

  def initialize(player_money)
    @money = player_money
  end

  def set
    super
    @loss = false
    @win = false
  end

  def self.check_money
    money = gets.to_i
  end

  def bet_money(bet)
    @money -= bet
  end

  def show_hand
    puts <<~text

           ----------- #{self.class} 手札 -----------
         text
    @hand.each.with_index(1) do |card, i|
      puts " #{i}枚目 ： #{card.card_info}"
    end
    puts "-----------------------------------"
  end

  def select_hit_or_stand
    action_num = gets.chomp.to_i
  end

  def set_win
    @win = true
  end

  def set_loss
    @loss = true
  end

  def settle(dividend)
    @money += dividend
    @money = 0 if @money < 0
  end

  def select_continue_or_end
    action_num = gets.chomp.to_i
  end
end
