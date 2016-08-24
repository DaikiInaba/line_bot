# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create Event

"http://image.com/ijiwhoh.png/700"

# Event.create(
#   name: '',
#   prefecture: '',
#   city: '',
#   started_at: '',
#   expired_at: '',
#   event_url: '',
#   # image_url: ''
#   )

Event.create(
  name: 'アートアクアリウム誕生10周年記念祭 アートアクアリウム展～大阪・金魚の艶～＆ナイトアクアリウム',
  prefecture: '大阪府',
  city: '大阪市',
  started_at: '20160706',
  expired_at: '20160905',
  event_url: 'http://artaquarium.jp',
  # image_url: 'http://artaquarium.jp/images/keyvisual/tb_10thanniv_osk2016_kv_jp_NM.jpg'
  )

Event.create(
  name: 'お台場みんなの夢大陸2016',
  prefecture: '東京都',
  city: '港区',
  started_at: '20160716',
  expired_at: '20160831',
  event_url: 'http://www.fujitv.co.jp/yumetairiku/index.html',
  # image_url: 'http://www.fujitv.co.jp/yumetairiku/photo/head_slide1.jpg'
  )

Event.create(
  name: 'トリック3Dアート「魔法の絵画展」',
  prefecture: '大阪府',
  city: '大阪市',
  started_at: '20160730',
  expired_at: '20160831',
  event_url: 'http://odorokids.net',
  # image_url: ''
  )

Event.create(
  name: 'SUMMER LIGHT GARDEN',
  prefecture: '東京都',
  city: '港区',
  started_at: '20160715',
  expired_at: '20160828',
  event_url: 'http://www.tokyo-midtown.com/jp/event/summer/summer_light.html',
  # image_url: ''
  )

Event.create(
  name: '光と音の体感ミュージアム　魔法の美術館',
  prefecture: '宮城県',
  city: '仙台市',
  started_at: '20160727',
  expired_at: '20160904',
  event_url: 'http://ox-tv.jp/sys_event/p/details.aspx?evno=183',
  # image_url: ''
  )

Event.create(
  name: '中之島ウエスト・夏ものがたり2016「都会で大人の夏まつり」',
  prefecture: '大阪府',
  city: '大阪市',
  started_at: '20160706',
  expired_at: '20160905',
  event_url: 'http://www.nakanoshima-west.jp/natsumonogatari2016.html',
  # image_url: ''
  )
