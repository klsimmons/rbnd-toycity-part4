module Analyzable

  def average_price(products)
    price = 0
    products.each do |product|
      price += product.price.to_f
    end
    (price /= products.length).round(2)
  end

  def print_report(products)
    report = "Average Price: #{average_price(products)}\n"
    report << format_count("brand", count_by_brand(products))
    report << format_count("name", count_by_name(products))
  end

  def count_by_brand(products)
    counter_method(products, 'brand')
  end

  def count_by_name(products)
    counter_method(products, 'name')
  end

  private

  def counter_method(products, metric)
    metric_hash = {}
    count = 0
    products.each { |product| metric_hash[product.send(metric)] = (count+1) }
    return metric_hash
  end

  def format_count(metric, hash)
    title = "Inventory by #{metric.capitalize}:\n"
    body = hash.reduce("") do |my_string, (key, value)|
      key == "No #{metric}" if key == ""
      my_string + "- #{key}: #{value}\n"
    end
    return title + body
  end
end
