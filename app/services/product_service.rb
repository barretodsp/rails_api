class ProductService < ApplicationService
  def self.create(product)
    success_resp = { notice: "Product created!", status: :ok }
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
    success_resp = { notice: "Product updated!", status: :ok }
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
    success_resp = { notice: "Product deleted!", status: :ok }
    transacional(success_resp) do
      product = get_valid(id)
      if product
        raise Exception.new(product.errors.values.join(", ")) unless product.desactivate()
      else
        raise Exception.new("Product invalid.")
      end
    end
  end

  private

  def self.get_valid(id)
    return nil if !(id && id.is_a?(Integer))
    Product.find_by_id(id)
  end
end
