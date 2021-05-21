class Character
  attr_reader :hand_cards, :point, :no_adjusted_point

  ADJUST_NUM = 10

  def reset
    @hand_cards = []
    @status = false
  end

  # カードを手札に加える
  def receive(drawn_card)
    @hand_cards << drawn_card
  end

  def decide_point
    @no_adjusted_point = false
    @point = @hand_cards.map(&:point).sum
    if has_a? && (@point + ADJUST_NUM <= Blackjack::BLACKJACK_NUM)
      @no_adjusted_point = @point
      @point += ADJUST_NUM
    end
  end

  def change(status)
    @status = status
  end

  def blackjack?
    @status == "blackjack"
  end

  def bust?
    @status == "bust"
  end

  private

  def has_a?
    @hand_cards.map(&:number).include?("A")
  end
end
