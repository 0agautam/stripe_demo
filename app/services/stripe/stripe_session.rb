class Stripe::StripeSession
  def initialize(price_id,user)
    @price_id = price_id
    @user = user
  end
  def call

    begin
    session = Stripe::Checkout::Session.create(
      success_url: "http://localhost:3000/billings/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "http://localhost:3000/billings",
      payment_method_types: ['card'],
      mode: 'subscription',
      customer_email: @user.email,
      line_items: [{
        quantity: 1,
        price: @price_id,
      }],
    )
    rescue Exception => ex
      puts ex
    end
  end

end