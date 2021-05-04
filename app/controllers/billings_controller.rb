class BillingsController < ApplicationController
  def index
    @plans = Plan.order(:price)
  end

  def new
    if current_user.subscription
      if current_user.subscription.active
          respond_to do |format|
            format.html { redirect_to billings_path, error:"You are already subscribed!!!" }
          end
      end
    else
      @session_data = Stripe::StripeSession.new(params[:price_id],current_user).call
      puts "Session Data is :#{@session_data}"
    end
  end

  def success
    ### the Stripe {CHECKOUT_SESSION_ID} will be available in params[:session_id]
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    
    if session.payment_status == "paid"

      @customer = Stripe::Customer.retrieve(session.customer)
      current_user.update(stripe_id: session.customer)
      @subscription = Stripe::Subscription.retrieve(session.subscription)

      
      start_date = Time.at(@subscription.current_period_start).to_date
      end_date = Time.at(@subscription.current_period_end).to_date
      plan = Plan.find_by(price_id:@subscription.plan.id)

      Subscription.create!(start_date:start_date, end_date:end_date, user_id:current_user.id, plan_id:plan.id)

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
