class OrdersController < ApplicationController

  def new
    @sale = Sale.find(params[:sale_id]) 
    @order = Order.new
    card = Card.where(user_id: current_user.id).first
    #テーブルからpayjpの顧客IDを検索
    if card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:private_key]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @card_infomation = customer.cards.retrieve(card.card_id)
    else
      #登録された情報がない場合何もしない
    end
  end

  def create
      #orderテーブルに購入者のIDと商品のIDを保存
    Order.create(buyer_id: current_user.id, sale_id: params[:sale_id])
    
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.credentials[:payjp][:private_key]
    Payjp::Charge.create(
      amount: Sale.find(params[:sale_id]).price, #価格
      customer: card.customer_id, #顧客ID
      currency: 'jpy', #日本円
    )

    Sale.find(params[:sale_id]).update(status:"shipping")
  end

end
