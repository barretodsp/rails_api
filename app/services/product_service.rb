class ProductService < ApplicationService
  def self.create(product)
    success_resp = { notice: "Product created!" }
    transacional(success_resp) do
      raise ActiveRecord::RecordInvalid.new(product) unless product.save
    end
  end

  def self.get_by_id(id)
    return { alert: "Invalid request.", status: 400 } unless valid_id?(id)
    product = Product.find_by_id(id)
    return { alert: "Product not found.", status: 404 } unless product
    { notice: product }
  end

  def self.update(id, params)
    success_resp = { notice: "Product updated!" }
    transacional(success_resp) do
      return { alert: "Invalid request.", status: 400 } unless valid_id?(id)
      product = Product.find_by_id(id)
      return { alert: "Product not found.", status: 404 } unless product
      raise ActiveRecord::RecordInvalid.new(product) unless product.update_attributes(params)
    end
  end

  def self.delete(id)
    success_resp = { notice: "Product deleted!" }
    transacional(success_resp) do
      return { alert: "Invalid request.", status: 400 } unless valid_id?(id)
      product = Product.find_by_id(id)
      return { alert: "Product not found.", status: 404 } unless product
      raise ActiveRecord::RecordInvalid.new(product) unless product.deactivate()
    end
  end
end
