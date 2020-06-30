class ProductService < ApplicationService
  def self.create(product)
    success_resp = { notice: "Product created!" }
    transacional(success_resp) do
      raise Exception.new(product.errors.values.join(", ")) unless product.save
    end
  end

  def self.get_by_id(id)
    product = get_valid(id)
    return { alert: "Invalid request." } unless product
    { notice: product }
  end

  def self.update(id, params)
    success_resp = { notice: "Product updated!" }
    transacional(success_resp) do
      product = get_valid(id)
      if product
        raise Exception.new(product.errors.values.join(", ")) unless product.update_attributes(params)
      else
        raise Exception.new("Product invalid.")
      end
    end
  end

  def self.delete(id)
    success_resp = { notice: "Product deleted!" }
    transacional(success_resp) do
      product = get_valid(id)
      if product
        raise Exception.new(product.errors.values.join(", ")) unless product.deactivate()
      else
        raise Exception.new("Product invalid.")
      end
    end
  end

  private

  def self.get_valid(id)
    return nil unless id
    Product.find_by_id(id)
  end
end
