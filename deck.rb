class Deck
  attr_reader :cards

  # カードデッキを作成し、シャッフルまで行う
  def initialize
    # デッキの配列を生成
    @cards = []

    marks = ["♤", "♡", "♢", "♧"]
    # numbers = ["10", "7", "Q", "4","A"] #シャッフルなしでプレイヤーがブラックジャックになる
    numbers = ["10", "Q", "4", "A","7"] #シャッフルなしでディーラーがブラックジャックになる
    # numbers = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q" ,"K"]
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

#インスタンス変数にしないとDeck.newに値が代入されない