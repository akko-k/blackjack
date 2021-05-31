class Character
  attr_reader :hand_cards, :point, :point_list

  ADJUST_NUM = 10
  BLACKJACK_HAND_CARDS_SIZE = 2
  BLACKJACK_POINT_LIST_SIZE = 2
  BLACKJACK_NUM = 21
  BLACKJACK = "blackjack"
  BUST = "bust"

  def reset
    @hand_cards = []
    @status = false
  end

  # カードを手札に加える
  def receive(drawn_card)
    @hand_cards << drawn_card
    calc_point
  end

  def blackjack?
    @status == "blackjack"
  end

  def bust?
    @status == "bust"
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
    @hand_cards.map(&:number).include?("A")
  end

  def change_status
    if @point == BLACKJACK_NUM && @hand_cards.size == BLACKJACK_HAND_CARDS_SIZE
      @status = BLACKJACK
    elsif @point > BLACKJACK_NUM
      @status = BUST
    end
  end
end
