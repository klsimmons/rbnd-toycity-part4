module Analyzable

  def average_price(products)
    price = 0
    products.each do |product|
      price += product.price.to_f
    end
    (price /= products.length).round(2)
  end

  def print_report(products)
    # TODO put avg price, counts by brand, counts by product name
    return "#{average_price(products)}"
  end

  def count_by_brand(products)
    brand_hash = {}
    count = 0
    products.each { |product| brand_hash[product.brand] = (count + 1) }
    return brand_hash
  end

  def count_by_name(products)
    name_hash = {}
    count = 0
    products.each { |product| name_hash[product.name] = (count + 1) }
    return name_hash
  end
end
