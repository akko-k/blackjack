class Deck

  # カードデッキを作成し、シャッフルまで行う
  def initialize
    # デッキの配列を生成
    deck = []

    marks = ["♤", "♡", "♢", "♧"]
    numbers = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q" ,"K"]

    marks.each do |mark|
      numbers.each do |number|
        # markとnumberの組み合わせを一つずつcardクラスに渡し、それぞれのcardオブジェクトを生成する
        card = Card.new(mark, number)
        # 生成したcardを配列に格納していく
        deck << card
      end
    end

    # デッキをシャッフルする
    deck.shuffle!
  end
end