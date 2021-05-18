class Character
  attr_reader :hand, :point_list, :points, :bust, :blackjack

  ADJUST_NUM = 10

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
    point = @hand.map{|card| card.point}.sum
    @point_list = [point]
    if has_a? && (point + ADJUST_NUM < Blackjack::BUST_NUM)
      @point_list.unshift(point + ADJUST_NUM)
    end
  end

  def determine_points
    @points = @point_list.max
  end

  def set_blackjack
    @blackjack = true
  end

  def set_bust
    @bust = true
  end

  private

  def has_a?
    @hand.map(&:number).include?('A')
  end
end

# class Character
#   attr_reader :hand, :points_list, :points, :bust, :blackjack

#   NUM_TO_ADJUST_POINT_1_TO_11 = 10

#   def set
#     @hand = []
#     @bust = false
#     @blackjack = false
#   end

#   # カードを手札に加える
#   def receive(drawn_card)
#     @hand << drawn_card
#   end

#   def calculate_points
#     p @hand
#     p points_sum = @hand[0].sum(&:point)
#     has_a = @hand.map(&:number).include?('A')

#     @point_list = [points_sum]

#     if has_a && (points_sum + NUM_TO_ADJUST_POINT_1_TO_11 < Blackjack::BUST_NUM)
#       @point_list.unshift(points_sum + NUM_TO_ADJUST_POINT_1_TO_11)
#     end
#   end

#   def determine_points
#     @points = @point_list.max
#   end

#   def set_blackjack
#     @blackjack = true
#   end

#   def set_bust
#     @bust = true
#   end
# end
