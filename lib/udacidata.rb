require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(attributes = {})
    item = Product.new(attributes)
    CSV.open(@@data_path, "a+") do |csv|
      if csv.include?(item.id) == false
        csv << [item.id, item.brand, item.name, item.price]
      end
    end
    return item
  end

  def self.all
    @product_array = []
    CSV.read(@@data_path, headers: true).each do |row|
      product = new({id: row['id'], brand: row['brand'], name: row['name'], price: row['price']})
      @product_array << product
    end
    return @product_array
  end

  def self.first(num=0)
    self.all
    num == 0 ? @product_array.first : @product_array.first(num)
  end


end
