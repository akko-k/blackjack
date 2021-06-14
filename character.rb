require_relative "rule"

class Character
  attr_reader :hand_cards, :point, :point_list

  include Rule

  def reset
    @hand_cards = []
    @status = nil
  end

  # カードを手札に加える
  def receive(drawn_card)
    @hand_cards << drawn_card
    calc_point
  end

  def blackjack?
    @status == BLACKJACK
  end

  def bust?
    @status == BUST
  end

  private

  def calc_point
    @point_list = []
    @point_list << @point = @hand_cards.map(&:point).sum
    if has_a? && (@point + ADJUST_NUM <= BLACKJACK_NUM)
      @point += ADJUST_NUM
      @point_list.unshift(@point)
    end
    change_status
  end

  def has_a?
    @hand_cards.map(&:is_ace?).any?
  end

  def change_status
    if @point == BLACKJACK_NUM && @hand_cards.size == BLACKJACK_HAND_CARDS_SIZE
      @status = BLACKJACK
    elsif @point > BLACKJACK_NUM
      @status = BUST
    end
  end
end
