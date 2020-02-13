# 大カテゴリ
ladies = Category.create(name: "レディース")
mens = Category.create(name: "メンズ")
kids = Category.create(name: "ベビー・キッズ")
interiors = Category.create(name: "インテリア・住まい・小物")
bgm = Category.create(name: "本・音楽・ゲーム")
hobbies = Category.create(name: "おもちゃ・ホビー・グッズ")
cosmetics = Category.create(name: "コスメ・香水・美容")
appliances = Category.create(name: "家電・スマホ・カメラ")
sports = Category.create(name: "スポーツ・レジャー")
handmades = Category.create(name: "ハンドメイド")
tickets = Category.create(name: "チケット")
automobiles = Category.create(name: "自動車・オートバイ")
others = Category.create(name: "その他")

# 中カテゴリ(レディース)
ladies_tops = ladies.children.create(name: "トップス")
ladies_jeckets = ladies.children.create(name: "ジャケット/アウター")
ladies_pants = ladies.children.create(name: "パンツ")
ladies_skirts = ladies.children.create(name: "スカート")
ladies_onepieces = ladies.children.create(name: "ワンピース")
ladies_shoes = ladies.children.create(name: "靴")
ladies_roomwares = ladies.children.create(name: "ルームウェア/パジャマ")
ladies_legwares = ladies.children.create(name: "レッグウェア")
ladies_hats = ladies.children.create(name: "帽子")
ladies_bags = ladies.children.create(name: "バッグ")
ladies_accesories = ladies.children.create(name: "アクセサリー")
ladies_hear_accesories = ladies.children.create(name: "ヘアアクセサリー")
ladies_trinkets = ladies.children.create(name: "小物")
ladies_watch = ladies.children.create(name: "時計")

# 小カテゴリ(レディース)
ladies_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"},{name: "Tシャツ/カットソー(七分/長袖)"},{name: "シャツ/ブラウス(半袖/袖なし)"},{name: "シャツ/ブラウス(七分/長袖)"},
  {name: "ポロシャツ"},{name: "キャミソール"},{name: "タンクトップ"},{name: "ホルターネック"},{name: "ニット/セーター"},{name: "チュニック"},{name: "カーディガン/ボレロ"},{name: "アンサンブル"},{name: "ベスト/ジレ"},{name: "パーカー"}])
ladies_jeckets.children.create([{name: "テーラードジャケット"},{name: "ノーカラージャケット"},{name: "Gジャン/デニムジャケット"},{name: "レザージャケット"},{name: "ダウンジャケット"},
{name: "ライダースジャケット"},{name: "ミリタリージャケット"},{name: "ダウンベスト"},{name: "ジャンパー/ブルゾン"},{name: "ポンチョ"},{name: "ロングコート"},{name: "トレンチコート"},{name: "ダッフルコート"},{name: "ピーコート"}])
ladies_pants.children.create([{name: "デニム/ジーンズ"},{name: "ショートパンツ"},{name: "カジュアルパンツ"},{name: "ハーフパンツ"},{name: "チノパン"},
{name: "ワークパンツ/カーゴパンツ"},{name: "クロップドパンツ"},{name: "サロペット/オーバーオール"},{name: "オールインワン"},{name: "サルエルパンツ"},{name: "ガウチョパンツ"}, {name: "その他"}])
ladies_skirts.children.create([{name: "ミニスカート"},{name: "ひざ丈スカート"},{name: "ロングスカート"},{name: "キュロット"},{name: "その他"}])
ladies_onepieces.children.create([{name: "ミニワンピース"},{name: "ひざ丈ワンピース"},{name: "ロングワンピース"},{name: "その他"}])
ladies_shoes.children.create([{name: "ハイヒール/パンプス"},{name: "ブーツ"},{name: "サンダル"},{name: "スニーカー"},
{name: "ミュール"},{name: "モカシン"},{name: "ローファー/革靴"},{name: "フラットシューズ/バレエシューズ"},{name: "長靴/レインシューズ"},{name: "その他"}])
ladies_roomwares.children.create([{name: "パジャマ"},{name: "ルームウェア"}])
ladies_legwares.children.create([{name: "ソックス"},{name: "スパッツ/レギンス"},{name: "ストッキング/タイツ"},{name: "レッグウォーマー"},{name: "その他"}])
ladies_hats.children.create([{name: "ニットキャップ/ビーニー"},{name: "ハット"},{name: "ハンチング/ベレー帽"},
{name: "キャップ"},{name: "キャスケット"},{name: "麦わら帽子"},{name: "その他"}])
ladies_bags.children.create([{name: "ハンドバッグ"},{name: "トートバッグ"},{name: "エコバッグ"},{name: "リュック/バックパック"},{name: "ボストンバッグ"},{name: "スポーツバッグ"},{name: "ショルダーバッグ"},
{name: "クラッチバッグ"},{name: "ポーチ/バニティ"},{name: "ボディバッグ/ウェストバッグ"},{name: "マザーズバッグ"},{name: "メッセンジャーバッグ"},{name: "ビジネスバッグ"},{name: "旅行用バッグ/キャリーバッグ"},])
ladies_accesories.children.create([{name: "ネックレス"},{name: "ブレスレット"},{name: "バングル/リストバンド"},{name: "リング"},
{name: "ピアス(片耳用)"},{name: "ピアス(両耳用)"},{name: "イヤリング"},{name: "アンクレット"},{name: "ブローチ/コサージュ"},{name: "チャーム"},{name: "その他"},])
ladies_hear_accesories.children.create([{name: "ヘアゴム/シュシュ"},{name: "ヘアバンド/カチューシャ"},{name: "ヘアピン"},{name: "その他"}])
ladies_trinkets.children.create([{name: "長財布"},{name: "折り財布"},{name: "コインケース/小銭入れ"},{name: "名刺入れ/定期入れ"},{name: "キーケース"},{name: "キーホルダー"},
{name: "手袋/アームカバー"},{name: "ハンカチ"},{name: "ベルト"},{name: "マフラー/ショール"},{name: "ストール/スヌード"},{name: "バンダナ/スカーフ"},{name: "ネックウォーマー"},{name: "サスペンダー"}])
ladies_watch.children.create([{name: "腕時計(アナログ)"},{name: "腕時計(デジタル)"},{name: "ラバーベルト"},{name: "レザーベルト"},{name: "金属ベルト"},{name: "その他"}])