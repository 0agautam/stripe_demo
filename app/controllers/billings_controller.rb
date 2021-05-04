class BillingsController < ApplicationController
  def index
    @plans = Plan.order(:price)
  end

  def new
    @session_data = Stripe::StripeSession.new(params[:price_id],current_user.email).call
    puts "Session Data is :#{@session_data}"
  end

  def success
    ### the Stripe {CHECKOUT_SESSION_ID} will be available in params[:session_id]
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    puts "Session: #{session.inspect}"
    @customer = Stripe::Customer.retrieve(session.customer)

    puts "Customer: #{@customer.inspect}"
    if params[:session_id]
      respond_to do |format|
        format.html { render success_billings_path, notice: 'Thanks for subscribing' }
      end

    else
      respond_to do |format|
        format.html { redirect_to billings_path, error:"Session expired!!!" }
      end
    end
  end

  def webhook
    response = StripeWebhooks.call
  end
end
