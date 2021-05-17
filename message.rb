module Message
  def start_message
    puts <<~TEXT
           ----------------------------------
           |                                |
           |           BLACK JACK           |
           |                                |
           ----------------------------------

         TEXT
  end

  def request_player_to_decide_bet_message
    puts <<~TEXT

           現在の所持金は#{@player.money}円です。
           掛け金を入力して下さい。

         TEXT
  end

  def info_bet_money_and_remaining_money
    puts <<~TEXT

           -------- money_information -------

           掛け金： #{@bet}円

           現在の所持金 ： #{@player.money}円

           ----------------------------------

         TEXT
  end

  def error_message_for_bet_money
    puts <<~TEXT

           ---------------------------------------------------------
           error ： 1以上，かつ所持金以下の数値を入力してください。
           ---------------------------------------------------------

         TEXT
  end

  def dealer_deals_cards_first_time_message
    puts <<~TEXT

           #{@dealer.class}がカードを2枚ずつ配ります。

         TEXT
  end

  def show_hand_first_time(dealer)
    puts <<~TEXT

           ----------- #{dealer.class} 手札 -----------
           1枚目 ： #{dealer.hand[0].card_info}
           2枚目 ： 伏せられている
           -----------------------------------
         TEXT
  end

  def show_hand(character)
    puts <<~TEXT

           ----------- #{character.class} 手札 -----------
         TEXT
    character.hand.each.with_index(1) do |card, i|
      puts " #{i}枚目 ： #{card.card_info}"
    end
    puts "-----------------------------------"
  end

  def info_points_message(character)
    points_index_0_message = "#{character.class}の手札の合計点数は #{character.points_list[0]}"
    points_index_1_message = "、もしくは #{character.points_list[1]} "

    print points_index_0_message

    if character.points_list.size == 2
      print points_index_1_message
    end

    puts "です。"
  end

  def info_determined_points_message(character)
    puts "#{character.class}の手札の合計点数は #{character.points}です。"
  end

  def info_blackjack_message(character)
    puts <<~TEXT

           #{character.class}の手札はブラックジャックです！

         TEXT
  end

  def request_to_select_hit_or_stand_message
    puts <<~TEXT

           #{@player.class}の行動を選択してください。

           #{Blackjack::HIT_NUM}. Hit #{Blackjack::STAND_NUM}. Stand

         TEXT
  end

  def error_message_about_hit_or_stand
    puts <<~TEXT
           --------------------------------------
           error ： #{Blackjack::HIT_NUM} か #{Blackjack::STAND_NUM} を入力してください。
           --------------------------------------
         TEXT
  end

  def info_bust_message(character)
    puts <<~TEXT

           #{character.class}がバーストしました。

         TEXT
  end

  def info_end_of_players_turn_message
    puts <<~TEXT

           #{@player.class}はカードを引き終わりました。

         TEXT
  end

  def check_dealers_first_hand_message
    puts <<~TEXT

           #{@dealer.class}の手札を確認します。

         TEXT
  end

  def info_dealer_draw_card_message
    puts <<~TEXT

           #{Blackjack::DEALER_STOP_DRAWING_NUM}点未満なので
           #{@dealer.class}はもう1枚カードを引きます。

         TEXT
  end

  def compare_points_message
    puts <<~TEXT

           勝敗判定に参りましょう。

         TEXT
  end

  def type_enter_message
    puts <<~TEXT

           （ キーボードでEnterキーを押してください。）
                
         TEXT
  end

  def player_win_message
    puts <<~TEXT

           おめでとうございます。#{@player.class}の勝ちです!

         TEXT
  end

  def player_lose_message
    puts <<~TEXT

           ディーラーの勝利。#{@player.class}の負けです。

         TEXT
  end

  def end_in_tie_message
    puts <<~TEXT


           合計得点が同点となりました。引き分けです。

           
         TEXT
  end

  def info_dividend_and_remaining_money_message(dividend)
    puts <<~TEXT

           -------- money_information -----------
           
           配当金： #{dividend}円

           現在の所持金 ： #{@player.money}円

           --------------------------------------

         TEXT
  end

  def info_gameover_message
    puts <<~TEXT

           所持金が0円になりました。

           ゲームオーバー

         TEXT
  end

  def request_to_select_continue_or_end_message
    puts <<~TEXT
           
           ゲームを続けますか？
           --------------------------------------

           #{Blackjack::GAME_CONTINUE_NUM}.ゲームを続ける #{Blackjack::GAME_END_NUM}.ゲームをやめる
        
           --------------------------------------
         TEXT
  end

  def error_message_about_continue_or_end
    puts <<~TEXT
          ----------------------------------------
            error ： #{Blackjack::GAME_CONTINUE_NUM} か #{Blackjack::GAME_END_NUM} を入力してください。
          ----------------------------------------
         TEXT
  end

  def game_continue_message
    puts <<~TEXT

           ゲームを続けます。

         TEXT
  end

  def game_end_message
    puts <<~TEXT

           ゲーム終了

         TEXT
  end
end
