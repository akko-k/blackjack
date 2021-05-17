class Character
  attr_reader :hand, :points_list, :points, :bust, :blackjack

  NUM_TO_ADJUST_POINT_1_TO_11 = 10

  def set
    @hand = []
    @bust = false
    @blackjack = false
  end

  # カードを手札に加える
  def receive(drawn_card)
    @hand << drawn_card
  end

  def calculate_points
    points_sum = @hand.sum(&:point)
    has_a = @hand.map(&:number).include?('A')

    @points_list = [points_sum]

    if has_a && (points_sum + NUM_TO_ADJUST_POINT_1_TO_11 < Blackjack::BUST_NUM)
      @points_list.unshift(points_sum + NUM_TO_ADJUST_POINT_1_TO_11)
    end
  end

  def determine_points
    @points = @points_list.max
  end

  def set_blackjack
    @blackjack = true
  end

  def set_bust
    @bust = true
  end
end
