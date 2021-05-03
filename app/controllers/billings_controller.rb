class BillingsController < ApplicationController
  def index
    @plans = Plan.order(:price)
  end

  def new
    @session_data = Stripe::StripeSession.new(params[:price_id],current_user.email).call
    puts "Session Data is :#{@session_data}"
    respond_to do |format|
      format.js
    end
  end

  def success
    ### the Stripe {CHECKOUT_SESSION_ID} will be available in params[:session_id]
    puts "P: #{params[:session_id]}"
    if params[:session_id].present?
      redirect_to success_billings_path, flash: {notice:'Thanks for subscribing'}
    else
      redirect_to billings_path, flash: {error:"Session expired!!!"}
    end
  end
end
