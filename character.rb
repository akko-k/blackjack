class Character
  attr_reader :hand_cards, :point, :point_list

  BLACKJACK_HAND_CARDS_SIZE = 2
  BLACKJACK_POINT_LIST_SIZE = 2
  BLACKJACK = 0
  BUST = 1

  def reset
    @hand_cards = []
    @status = false
  end

  # カードを手札に加える
  def receive(drawn_card, blackjack_num, adjust_num)
    @hand_cards << drawn_card
    calc_point(blackjack_num, adjust_num)
  end

  def blackjack?
    @status == BLACKJACK
  end

  def bust?
    @status == BUST
  end

  private

  def calc_point(blackjack_num, adjust_num)
    @point_list = []
    @point_list << @point = @hand_cards.map(&:point).sum
    if has_a? && (@point + adjust_num <= blackjack_num)
      @point += adjust_num
      @point_list.unshift(@point)
    end
    change_status(blackjack_num)
  end

  def has_a?
    @hand_cards.map(&:is_ace?).any?
  end

  def change_status(blackjack_num)
    if @point == blackjack_num && @hand_cards.size == BLACKJACK_HAND_CARDS_SIZE
      @status = BLACKJACK
    elsif @point > blackjack_num
      @status = BUST
    end
  end
end
