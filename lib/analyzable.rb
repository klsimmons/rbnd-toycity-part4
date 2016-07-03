module Analyzable

  def average_price(products)
    price = 0
    products.each do |product|
      price += product.price.to_f
    end
    (price /= products.length).round(2)
  end
end
