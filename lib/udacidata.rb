require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  def self.create(attributes = {})
    item = Product.new(attributes)
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(@data_path, "a+") do |csv|
      if csv.include?(item.id) == false
        csv << [item.id, item.brand, item.name, item.price]
      end
    end
    return item
  end

  def self.all
    product_array = []
  end


end
