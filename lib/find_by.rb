require_relative 'errors'

class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      finder_method = %Q{
        def self.find_by_#{attribute}(value)
          products = self.all
          if "#{attribute}" == "id"
            raise UdacitaskErrors::ProductNotFoundError if value > products.length
          end
          products.find(Proc.new {raise UdacitaskErrors::ProductNotFoundError}) { |product| product.#{attribute} == value }
        end
      }
      self.class_eval(finder_method)
    end
  end
end
