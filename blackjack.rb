require "./deck"
require "./card"
require "./player"
require "./dealer"
require "./message"

class Blackjack
  HIT_NUM = 1
  STAND_NUM = 2
  BUST_NUM = 22
  BLACK_JACK = 21
  DEALER_DRAW_NUM = 17
  RATE = 2.5

  include Message
  
  def self.request_player_to_check_money
    player_money = 0
    puts "所持金を入力して下さい。"
    loop do
      player_money = Player.check_money
      break if player_money >= 1
      puts <<~text

          ---------------------------------------------
          error ： 1円以上でゲームに参加してください。
          ---------------------------------------------

          text
    end
    player_money
  end

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  def deal_cards
    start_message
    @deck = Deck.new

    loop do #ゲーム自体の仕切り直し
      
      @dealer.init
      @player.init

      request_player_to_bet

      deal_cards_first_time

      if @player.points_list[0] == BLACK_JACK
        info_blackjack_message(@player)
        @player.set_blackjack
      else
        info_points_message(@player)
        start_players_turn
      end

      # プレイヤーがバーストしていなければディーラーの番
      if @player.bust == false
        start_dealers_turn
      end

      # 両者バーストしてなければ，ポイント比較による勝敗判定
      if @player.bust == false && @dealer.bust == false
        judge_winner_by_points
      end

      
    end 
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

  def deal_cards_first_time
    # 配り方はプレイヤー1枚目→ディーラー1枚目（見せる）→プレイヤー2枚目→ディーラー2枚目（伏せる）
    dealer_deals_cards_message(@dealer)
    2.times do
      deal_card_to(@player)
      deal_card_to(@dealer)
    end
    @dealer.show_hand_first_deal
    @player.show_hand
    @player.calculate_points
  end

  def deal_card_to(character)
    drawn_card = @dealer.draw_card(@deck)
    character.receive(drawn_card)
  end

  # プレイヤーの番
  def start_players_turn
    loop do
      action_num = request_player_to_select_hit_or_stand
      
      case action_num
      when STAND_NUM
        info_end_of_players_turn_message
        break
      when HIT_NUM
        deal_card_to(@player)
        @player.show_hand
        @player.calculate_points
        info_points_message(@player)

        if BUST_NUM <= @player.points_list[0]
          info_bust_message(@player)
          @player.set_bust
          @player.set_loss
          player_lose_message
          return
        end
      end
    end
  end

  def request_player_to_select_hit_or_stand
    request_to_select_hit_or_stand_message(hit_num: HIT_NUM, stand_num: STAND_NUM)
    action_num = 0
    loop do
      action_num = @player.select_hit_or_stand
      break if action_num == HIT_NUM || action_num == STAND_NUM
      error_message_about_select_action_num(hit_num: HIT_NUM, stand_num: STAND_NUM)
    end
    action_num
  end

  # ディーラーの番
  def start_dealers_turn   
    # 1回目に配ったカードを見せる
    check_dealers_first_hand_message
    @dealer.show_hand
    @dealer.calculate_points
    

    # 最初の2枚がブラックジャックならフラグを立てる
    if @dealer.points_list[0] == BLACK_JACK
      info_blackjack_message(@dealer)
      @dealer.set_blackjack
    else
      info_points_message(@dealer)
    end

    return if @player.blackjack == true

    # 17未満の間はカードを引く
    while @dealer.points_list[0] < DEALER_DRAW_NUM
      info_dealer_drow_card(dealer_draw_num: DEALER_DRAW_NUM)
      deal_card_to(@dealer)
      @dealer.show_hand
      @dealer.calculate_points
      info_points_message(@dealer)
    end
    
    if DEALER_DRAW_NUM <= @dealer.points_list[0] && @dealer.points_list[0] < BUST_NUM
      return
    elsif BUST_NUM <= @dealer.points_list[0]
      info_bust_message(@dealer)
      @dealer.set_bust
      @dealer.set_loss
      player_win_message
    end
  end

  def judge_winner_by_points
    compare_points_message
    @player.show_hand
    @player.blackjack == false ? info_points_message(@player) : info_blackjack_message(@player)
    @dealer.show_hand
    @dealer.blackjack == false ? info_points_message(@dealer) : info_blackjack_message(@dealer)
    

    if @dealer.points_list[0] < @player.points_list[0]
      player_win_message
      @dealer.set_loss
    elsif @player.points_list[0] < @dealer.points_list[0]
      player_lose_message
      @player.set_loss
    else
      judge_winner_when_points_are_same
    end
  end
end

def judge_winner_when_points_are_same
  if @player.blackjack == true && @dealer.blackjack == false
    player_win_message
    @dealer.set_loss
  elsif @player.blackjack == false && @dealer.blackjack == true
    player_lose_message
    @player.set_loss
  else
    end_in_tie_message
  end
end