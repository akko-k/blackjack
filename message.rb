module Message

  def start_message
    puts <<~text
    ----------------------------------
    |                                |
    |           BLACK JACK           |
    |                                |
    ----------------------------------

    text
  end

  def request_plyaer_to_decide_bet_message
    puts <<~text

      現在の所持金は#{@player.money}円です。
      掛け金を入力して下さい。

      text
  end

  def info_bet_money_and_remaining_money
    puts <<~text

          -------- money_information -------
          掛け金： #{@bet}円
          残り所持金 ： #{@player.money}円
          ----------------------------------

          text
  end

  def error_message_for_bet_money
    puts <<~text

          ------------------------------------------------
          error ： 1以上，かつ所持金以下の数値を入力してください。
          ------------------------------------------------

          text
  end

  def dealer_deals_cards_message(character)
    puts <<~text

      #{character.class}がカードを
      2枚ずつ配ります

      text

  end

  
  def info_points_message(character)
    if character.points_list.size == 1
      puts "#{character.class}の手札の合計点数は #{character.points_list[0]} です。"
    else
      puts "#{character.class}の手札の合計点数は #{character.points_list[0]}、もしくは #{character.points_list[1]} です。"
    end
  end

  def info_blackjack_message(character)
    puts <<~text

      #{character.class}の手札はブラックジャックです！

      text
  end

  def request_to_select_hit_or_stand_message(hit_num: HIT_NUM, stand_num: STAND_NUM)
    puts <<~text

        #{@player.class}の行動を選択してください。

        #{hit_num}. Hit #{stand_num}. Stand

        text
  end

  def error_message_about_select_action_num(hit_num: HIT_NUM, stand_num: STAND_NUM)
    puts <<~text
          --------------------------------------
          error ： #{hit_num} か #{stand_num} を入力してください。
          --------------------------------------
          text
  end

  def info_end_of_players_turn_message
    puts <<~text

        #{@player.class}はカードを引き終わりました

        text
  end

  def check_dealers_first_hand_message
    puts <<~text

        #{@dealer.class}の手札を確認します

        text
  end

  def info_dealer_drow_card(dealer_draw_num: DEALER_DRAW_NUM)
    puts <<~text

        #{dealer_draw_num}点未満なので
        #{@dealer.class}はもう1枚カードを引きます

        text

  end

  def compare_points_message
    puts <<~text

        勝敗判定に参りましょう

        text
  end

  def player_win_message
    puts <<~text

      おめでとうございます。#{@player.class}の勝ちです!

      text
  end

  def player_lose_message
    puts <<~text

      ディーラーの勝利。#{@player.class}の負けです。

      text
  end

  def end_in_tie_message
    puts <<~text


      合計得点が同点となりました。引き分けです。

      ---------money_information--------
      text
  end

  # def end_message
  #   puts <<~text

  #       所持金が0円になりました。
  #       ----------------------------------

  #       ゲームオーバー

  #       text
  # end

  # def continue_or_end_message
  #   puts <<~text
  #       現在の所持金 ： #{@player.money}円
  #       ----------------------------------

  #       1.ゲームを続ける 2.ゲームをやめる

  #       text
  # end

  # def information5
  #   puts <<~text

  #         ゲーム続行

  #         text
  # end

  # def information6
  #   puts <<~text

  #         ゲーム終了

  #         text
  # end

  # def information9
  #   puts <<~text


  #     ブラックジャック！おめでとうございます。#{@player.class}の勝ちです。

  #     text
  # end

  # def money_information
  #   puts "---------money_information--------"
  #   puts "支払われる金額 ： #{@paid}円"
  # end

  def info_bust_message(character)
    puts <<~text

    #{character.class}がバーストしました。

    text
  end
end