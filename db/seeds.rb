# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create Event

regions = ["渋谷", "新宿", "原宿", "池袋", "吉祥寺", "品川", "お台場", "銀座", "東京", "上野"]
regions.each do |region|
  data = Region.where(name: region).first_or_initialize
  data.save
end

# create BotMessage

BotMessage.create(
  text: "ようこそ、迷える彼氏を助ける、略して迷彼botへ<section>あなたもまた、迷彼のようね<section>ここは彼氏達のための互助会のようなものよ<section>初めに、あなたが真の迷彼なのか見定めさせてもらうわ",
  stage: 0
)

BotMessage.create(
  text: "まず、彼女とよく行く場所を聞いてもいいかしら？\n(例：渋谷、新宿、池袋、吉祥寺)",
  stage: 1
)


BotMessage.create(
  text: "今の彼女とは付き合い始めて何ヶ月なの？",
  stage: 2
)

BotMessage.create(
  text: "その娘とはどこで出会ったの？馴れ初めを教えてちょうだい？",
  stage: 3
)

BotMessage.create(
  text: "質問はこれで全部よ！ちゃんと答えてくれて嬉しいわ！<section>あなたが迷彼の仲間としてふさわしいか、少し考えさせてくれるかしら？<section>.........<section>.........<section>待たせたわね。\nあなたは迷彼の仲間としてふさわしいと思うわ。<section>これからは同じ迷彼として、お互いに相談してみんなが幸せになることを祈っているわ<section>(本来はここに使い方挟みます)",
  stage: 4
)
