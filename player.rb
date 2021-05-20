require_relative "character"

class Player < Character
  attr_reader :money, :bet, :loss, :win

  INITIAL_MONEY = 10_000

  def initialize
    @money = INITIAL_MONEY
  end

  def set
    super
    @loss = false
    @win = false
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

  def select_continue_or_end #ここはselect_actionにまとめても大丈夫か？
    action_num = gets.chomp.to_i
  end
end
