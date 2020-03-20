class CardController < ApplicationController
  require "payjp"
  before_action :set_card

  def index
    if @card.present?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)    
    end
  end

  def new
    card = Card.where(user_id: current_user.id).first
    redirect_to action: "index" if card.present?
  end

  def create
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']

    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end