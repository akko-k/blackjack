class Deck
  attr_reader :cards

  # カードデッキを作成し、シャッフルまで行う
  def initialize
    # デッキの配列を生成
    @cards = []

    marks = ["♤", "♡", "♢", "♧"]
    numbers = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q" ,"K"]
    marks.each do |mark|
      numbers.each do |number|
        # markとnumberの組み合わせを一つずつcardクラスに渡し、それぞれのcardオブジェクトを生成する
        card = Card.new(mark, number)
        # 生成したcardを配列に格納していく
        @cards << card
      end
    end
    @cards#.shuffle!
  end
end

# オリジナル
# numbers = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q" ,"K"]

# 以下確認用 （※シャッフルなしで実行）

# 引き分けの場合
# ★numbers = ["J", "J", "A","A"] # 両者ブラックジャック
# ★numbers = ["9", "7", "8","10"] # 両者17

# プレイヤーが勝つ場合
# ★numbers = ["9", "10", "8", "9"] #プレイヤーが19，ディーラーが17
# ★numbers = ["10", "7", "Q", "4", "A"] #プレイヤーがブラックジャック，ディーラー3枚目に21になる予定だけど引かずに終わる
# ★numbers = ["10", "7", "Q", "6", "A"] #プレイヤーがブラックジャック，ディーラー3枚目にバーストだけど引かずに終わる ※要確認
# ★numbers = ["9", "Q", "10", "A"] #プレイヤーがブラックジャック，ディーラー19
# ★numbers = ["J", "5", "10", "8", "9"] #プレイヤーが19，ディーラーがバースト

# プレイヤーが負ける場合
# ★numbers = ["10", "9", "9", "8"] #プレイヤーが17，ディーラーが19
# ★numbers = ["10", "Q", "4", "A", "7"] #プレイヤーが3枚で21，ディーラーがブラックジャック
# ★numbers = ["J", "Q", "5", "A", "8"] #プレイヤーがバースト，ディーラーがブラックジャック ※要確認
# ★numbers = ["Q", "9", "A", "10"] #プレイヤーが19，ディーラーブラックジャックだけど表示されずに終わる
# numbers = ["J","10", "5", "9", "8"] #プレイヤーがバースト，ディーラーが19だけど表示されずに終わる

# -----------
# numbers = ["Q","A","7", "A", "Q","A"] # Aの計算確認用
