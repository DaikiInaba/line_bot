# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create Event

regions = ["練馬", "板橋", "北", "足立", "葛飾", "杉並", "中野", "豊島", "文京", "荒川", "世田谷", "渋谷", "新宿", "千代田", "台東", "墨田", "目黒", "港", "中央", "江東", "江戸川", "品川", "大田"]
regions.each do |region|
  data = Region.where(name: region).first_or_initialize
  data.save
end

# create BotMessage

BotMessage.create(
  text:
"ようこそ、迷える彼氏、略して迷彼Botへ！
<section>
まず、あなたが真の迷える彼氏なのか、私が見定めてあげるわ♪
これからいろいろ質問するから、真剣に答えるのよ♪
",
  stage: 0
)

BotMessage.create(
  text: "彼女とよく行く場所を教えてくれる？",
  stage: 1
)


BotMessage.create(
  text: "今の彼女とは付き合い始めて何ヶ月なの？",
  stage: 2
)

BotMessage.create(
  text: "馴れ初めを詳しく教えてちょうだい？",
  stage: 3
)

BotMessage.create(
  text: "確かにあなたは迷える彼氏のようね！",
  stage: 4
)
