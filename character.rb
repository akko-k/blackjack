class Character
  attr_reader :hand, :point_list, :point, :bust, :blackjack

  ADJUST_NUM = 10

  def set
    @hand = []
    @blackjack = false
  end

  # カードを手札に加える
  def receive(drawn_card)
    @hand << drawn_card
  end

  def calculate_point
    point = @hand.map(&:point).sum # @hand.map{|card|card.point}.sumのほうが分かりやすい？
    @point_list = [point]
    if has_a? && (point + ADJUST_NUM < Blackjack::BUST_NUM)
      @point_list.unshift(point + ADJUST_NUM)
    end
  end

  def decide_point
    @point = @point_list.max
  end

  def set_blackjack
    @blackjack = true
  end

  private

  def has_a?
    @hand.map(&:number).include?('A')# @hand.map{|card|card.number}.include?('A')のほうが分かりやすい？
  end
end