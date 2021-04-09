require "./deck"
require "./card"
require "./player"
require "./dealer"
require "./message"

class Blackjack

  include Message

  BUST_NUMBER = 22
  BLACK_JACK = 21
  DEALER_DRAW_NUMBER = 16
  RATE = 1.5

  def start

    start_message

    while true
      build_player
      build_deck
      build_dealer
      @count_11 = 0
      @count_11_dealer = 0
      @player_bust_flag = 0
      @dealer_bust_flag = 0

      disp_money(@player)

      request_bet(@player)

      information1

      @dealer.first_draw_dealer(@deck)
      @dealer_point = point_dealer
      @player.first_draw_player(@deck)
      @player_point = point_player

      if @count_11 == 0
        player_point_information1
      else
        player_point_information2
      end

      while true

        information2

        action = gets.chomp.to_i

        if action == 1
          @player.draw_player(@deck)
          @player_point = point_player

          if @count_11 == 0
            player_point_information1
          else
            player_point_information2
          end

          bust_check

          if @player_bust_flag == 1
            information13
            break
          end

        elsif action == 2
          break

        else
          information3

        end

      end

      if @player_bust_flag == 0

        while @dealer_point <= DEALER_DRAW_NUMBER
          @dealer.draw_dealer(@deck)
          @dealer_point = point_dealer

          bust_check

        end

        information4

        judge

      end

      if @player.money <= 0
        end_message
        break

      else

        continue_or_end_message

        continue = gets.chomp.to_i

        if continue == 1
          information5

        elsif continue == 2
           information6
          break

        else

          information7

        end
      end
    end
  end

  def bust_check
    if @player_point >= BUST_NUMBER
      @player_bust_flag = 1

    elsif @dealer_point >= BUST_NUMBER
      @dealer_bust_flag = 1

    end
  end

  def judge

    @dealer.hands_show_dealer
    @dealer_point = point_dealer

    dealer_point_information1

    @player.hands_show_player
    @player_point = point_player

    player_point_information4

    if @dealer_point == @player_point
      information8
      @money_show = @player.paid_money(@bet)

    elsif @player_point == BLACK_JACK
      information9
      @paid = @bet + @bet*RATE
      @money_show = @player.paid_money(@paid.floor)
      money_information1

    elsif @dealer_bust_flag == 1
      information10
      @paid = @bet + @bet
      @money_show = @player.paid_money(@paid.floor)
      money_information2

    elsif @dealer_point > @player_point
      information11

    else
      information12
      @paid = @bet + @bet
      @money_show = @player.paid_money(@paid.floor)
      money_information3

    end
  end

  private
    def build_player
      @player = Player.new
    end

    def build_deck
      @deck = Deck.new
    end

    def build_dealer
      @dealer = Dealer.new
    end

    def point_player
      player_point = 0
      count_a = 0

      @player.hands.each do |hand|
        player_point += point(hand)
        #「A」が何回出たかを計算
        if point(hand) == 0
          count_a += 1
        end
      end

      count_a.times do |i|
        if player_point <= 10
          player_point += 11
          @count_11 = 1
        else
          player_point += 1
          @count_11 = 0
        end
      end

      return player_point
    end

    def point_dealer
      dealer_point = 0
      count_a = 0

      @dealer.hands.each do |hand|
        dealer_point += point(hand)
        if point(hand) == 0
          count_a += 1
        end
      end

      count_a.times do |i|
        if dealer_point <= 10
          dealer_point += 11
          @count_11_dealer = 1
        else
          dealer_point += 1
          @count_11_dealer = 0
        end
      end

      dealer_point
    end

    def point(card)
      if card.number == "J" || card.number == "Q" || card.number == "K"
        return number = 10
      elsif card.number == "A"
        return number = 0
      else
        return card.number.to_i
      end
    end

    def request_bet(player)
      while true
        @bet = gets.chomp.to_i

        if @bet.between?(1, player.money)
          @money_show = player.bet_money(@bet)
          money_information4

          break
        else
          information14

        end
      end
    end
end