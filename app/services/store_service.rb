class StoreService < ApplicationService
  def self.create(store)
    success_resp = { notice: "Store created!" }
    transacional(success_resp) do
      raise Exception.new(store.errors.values.join(", ")) unless store.save
    end
  end

  def self.get_by_id(id)
    store = get_valid(id)
    return { alert: "Invalid request." } unless store
    { notice: store }
  end

  def self.update(id, params)
    success_resp = { notice: "Store updated!" }
    transacional(success_resp) do
      store = get_valid(id)
      if store
        raise Exception.new(store.errors.values.join(", ")) unless store.update_attributes(params)
      else
        raise Exception.new("Store invalid.")
      end
    end
  end

  def self.delete(id)
    success_resp = { notice: "Store deleted!" }
    transacional(success_resp) do
      store = get_valid(id)
      if store
        raise Exception.new(store.errors.values.join(", ")) unless store.deactivate()
      else
        raise Exception.new("Store invalid.")
      end
    end
  end

  private

  def self.get_valid(id)
    return nil unless id
    Store.find_by_id(id)
  end
end
