class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find, only: [:index, :create]

  def index
    redirect_to root_path if @item.user_id == current_user.id || @item.buy.present?
    @buy_delivery = BuyDelivery.new
  end

  def create
    @buy_delivery = BuyDelivery.new(buy_params)
    if @buy_delivery.valid?
      pay_item
      @buy_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buy_params
    params.require(:buy_delivery).permit(:postage_code, :prefecture_id, :municipality, :house_num, :building_name, :telephone_num).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: buy_params[:token],
      currency: 'jpy'
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end
end
