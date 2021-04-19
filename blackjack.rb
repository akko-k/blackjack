require "./deck"
require "./card"
require "./player"
require "./dealer"
require "./message"

class Blackjack
  include Message
  NUM_TO_ADJUST_POINTS_WHEN_INCLUDING_A = 10
  HIT_NUM = 1
  STAND_NUM = 2
  BUST_NUMBER = 22
  BLACK_JACK = 21
  DEALER_DRAW_NUMBER = 17
  RATE = 2.5

  def self.request_player_to_check_money
    player_money = 0
    puts "所持金を入力して下さい。"
    loop do
      player_money = Player.check_money
      break if player_money >= 1
      puts "1円以上でゲームに参加してください"
    end
    player_money
  end

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  def start
    start_message
    @deck = Deck.new

    while true #ゲーム自体の仕切り直し
      
      reset_hand(@dealer)
      reset_hand(@player)
      p @deck.cards.size
      request_player_to_bet

      # 配り方はプレイヤー1枚目→ディーラー1枚目（見せる）→プレイヤー2枚目→ディーラー2枚目（伏せる）
      dealer_deals_cards_message
      2.times do
        deal_card_to(@player)
        deal_card_to(@dealer)
      end
      @dealer.show_hand
      @player.show_hand
      sum_of_points = @player.calculate_points(num_to_adjust_points_when_including_a: NUM_TO_ADJUST_POINTS_WHEN_INCLUDING_A)
      info_sum_of_points_message(@player,sum_of_points)
      
      if @player.sum_of_points == BLACK_JACK
        @player.put_up_brackjack_flag
      end
      
      until @player.brackjack_flag == true #ゲームの中でカードを追加するかどうか
        players_select_action_num = request_player_to_select_hit_or_stand
        
        case players_select_action_num
        when HIT_NUM
          deal_card_to(@player)
          @player.show_hand
          sum_of_points = @player.calculate_points(num_to_adjust_points_when_including_a: NUM_TO_ADJUST_POINTS_WHEN_INCLUDING_A)
          info_sum_of_points_message(@player,sum_of_points)

          if bust?(@player, sum_of_points)
            info_bust_message(@player)
            @player.put_up_bust_flag
            break
          end
        when  STAND_NUM
          break
        end
      end #playerの追加が終わり

      
    end # 1回のゲームが終わり（勝敗，精算まで）
  end #startの終わり

  private

  def reset_hand(character)
    character.reset_hand(character)
  end

  def request_player_to_bet
    request_plyaer_to_decide_bet_message
    loop do
      @bet = gets.chomp.to_i
      if @bet.between?(1, @player.money)
        @player.bet_money(@bet)
        info_bet_money_and_remaining_money #賭け金と残り所持金を表示
        break
      end
      error_message_for_bet_money # 1以上，かつ所持金以下の数値を入力してください
    end
  end

  def deal_card_to(character)
    drawn_card = @dealer.draw_card(@deck)
    character.receive(drawn_card)
  end

  def bust?(character, sum_of_points)
    BUST_NUMBER <= sum_of_points[0]
  end

  def request_player_to_select_hit_or_stand
    request_to_select_hit_or_stand_message(hit_num: HIT_NUM, stnad_num: STAND_NUM)
    players_select_action_num = 0
    loop do
      players_select_action_num = @player.select_hit_or_stand
      break if players_select_action_num == HIT_NUM || players_select_action_num == STAND_NUM
      error_message_about_select_action_num
    end
    players_select_action_num
  end
end
