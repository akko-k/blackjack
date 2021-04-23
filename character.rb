class Character
  attr_reader :points_list, :points, :bust, :blackjack

  NUM_TO_ADJUST_POINT_1_to_11 = 10

  def set
    @hand = []
    @bust = false
    @blackjack = false
  end

  # カードを手札に加える
  def receive(drawn_card)
    @hand << drawn_card
  end

  def calculate_points(bust_num: BUST_NUM)
    points_sum = 0
    count_a = 0
    adjusted_flag = 0

    @hand.each do |card|
      points_sum += convert_to_point(card)
      #「A」が何回出たかカウント
      if convert_to_point(card) == 1
        count_a += 1
      end
    end

    if count_a >= 1
      if points_sum + NUM_TO_ADJUST_POINT_1_to_11 < bust_num
        points_sum += NUM_TO_ADJUST_POINT_1_to_11
        adjusted_flag = 1
      end
    end

    @points_list = []
    @points_list << points_sum

    if adjusted_flag == 1
      @points_list << points_sum - NUM_TO_ADJUST_POINT_1_to_11
    end
  end

  def determine_points
    @points = @points_list[0]
  end

  def set_blackjack
    @blackjack = true
  end

  def set_bust
    @bust = true
  end

  private

  def convert_to_point(card)
    case card.number
    when "J", "Q", "K"
      10
    when "A"
      1
    else
      card.number.to_i
    end
  end
end
