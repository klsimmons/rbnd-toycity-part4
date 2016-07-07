require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  # 'find' is being used as an alternate name for 'find_by_id' which is created in the find_by module
  create_finder_methods :name, :brand, :id
  singleton_class.send :alias_method, :find, :find_by_id
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(attributes = nil)
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
    CSV.foreach(@@data_path, headers: true) do |row|
      @product_array << new(id: row['id'], brand: row['brand'], name: row['product'], price: row['price'])
    end
    return @product_array
  end

  def self.first(num=0)
    self.all
    num == 0 ? @product_array.first : @product_array.first(num)
  end

  def self.last(num=0)
    self.all
    num == 0 ? @product_array.last : @product_array.last(num)
  end

  def self.destroy(id)
    deleted = nil
    table = CSV.table(@@data_path)

    table.delete_if do |row|
      deleted = Product.new(row) if row[:id] == id
    end
    raise UdacitaskErrors::ProductNotFoundError if deleted == nil
    File.open(@@data_path, 'w')  { |f| f.write(table.to_csv) }
    deleted
  end

  def self.where(options = {})
    products = self.all
    products.keep_if { |product| product.brand == options[:brand] || product.name == options[:name] }
    return products
  end

  def update(options = {})
    @brand = options[:brand] || self.brand
    @price = options[:price] || self.price
    @name  = options[:name] || self.name
    Product.destroy(@id)
    Product.create(id: @id, brand: @brand, price: @price, name: @name)
  end

end
