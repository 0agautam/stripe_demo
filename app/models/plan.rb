class Plan < ApplicationRecord
  
  def self.get_api_price
    Stripe::Plan.list[:data].each do |plan|
      productId = plan['product']
      priceId = plan['id']
      priceAmount = plan['amount']/100;
      product = Stripe::Product.retrieve(productId)
      productName = product['name']
      productDescription = product['description']
      Plan.create!(title: productName, description: productDescription, price_id:priceId, price:priceAmount)
    end
  end
end



