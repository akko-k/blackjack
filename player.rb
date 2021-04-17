require_relative "character.rb"
class Player < Character
  attr_reader :money, :bet

  def initialize(money)
    @hand = []
    @money = money
  end

  def bet_money(bet)
    @money -= bet
  end

  def paid_money(money)
    @money += money
  end
end