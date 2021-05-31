require_relative "character"

class Player < Character
  attr_reader :money, :bet

  INITIAL_MONEY = 10_000

  def initialize
    @money = INITIAL_MONEY
  end

  def reset
    super
    @game_result = false
  end

  def decide_bet
    bet = gets.chomp.to_i
  end

  def bet_money(bet)
    @money -= bet
  end

  def select_action
    action_num = gets.chomp.to_i
  end

  def set(game_result)
    @game_result = game_result
  end

  def win?
    @game_result == Blackjack::WIN
  end

  def loss?
    @game_result == Blackjack::LOSS
  end

  def settle(dividend)
    @money += dividend
    @money = 0 if @money < 0
  end
end
