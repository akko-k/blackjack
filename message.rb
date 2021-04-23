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

  def info_bet_money_and_remaining_money(bet)
    puts <<~TEXT

           -------- money_information -------

           掛け金： #{bet}円

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

  def request_to_select_hit_or_stand_message(hit_num: HIT_NUM, stand_num: STAND_NUM)
    puts <<~TEXT

           #{@player.class}の行動を選択してください。

           #{hit_num}. Hit #{stand_num}. Stand

         TEXT
  end

  def error_message_about_hit_or_stand(hit_num, stand_num)
    puts <<~TEXT
           --------------------------------------
           error ： #{hit_num} か #{stand_num} を入力してください。
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

  def info_dealer_drow_card(dealer_stop_drawing_num: DEALER_STOP_DRAWING_NUMnts)
    puts <<~TEXT

           #{dealer_stop_drawing_num}点未満なので
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

  def info_dividend_remaining_money_message(breakdown, absolute_value_of_dividend)
    puts <<~TEXT

           -------- money_information -----------
 
           #{breakdown} ： #{absolute_value_of_dividend}円

           現在の所持金 ： #{@player.money}円

           --------------------------------------

         TEXT
  end

  def info_end_message
    puts <<~TEXT

           所持金が0円になりました。

           ゲームオーバー

         TEXT
  end

  def request_to_select_continue_or_end_message(game_continue_num: GAME_CONTINUE_NUM, game_end_num: GAME_END_NUM)
    puts <<~TEXT
           
           ゲームを続けますか？
           --------------------------------------

           #{game_continue_num}.ゲームを続ける #{game_end_num}.ゲームをやめる
        
           --------------------------------------
         TEXT
  end

  def error_message_about_continue_or_end(game_continue_num: GAME_CONTINUE_NUM, game_end_num: GAME_END_NUM)
    puts <<~TEXT
           -----------------------------------
           error ： #{game_continue_num} か #{game_end_num} を入力してください。
          ------------------------------------
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
