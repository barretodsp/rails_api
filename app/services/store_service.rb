class StoreService < ApplicationService
  def self.create(store)
    success_resp = { notice: "Store created!" }
    transacional(success_resp) do
      raise ActiveRecord::RecordInvalid.new(store) unless store.save
    end
  end

  def self.get_by_id(id)
    return { alert: "Invalid request.", status: 400 } unless valid_id?(id)
    store = Store.find_by_id(id)
    return { alert: "Store not found.", status: 404 } unless store
    { notice: store }
  end

  def self.update(id, params)
    success_resp = { notice: "Store updated!" }
    transacional(success_resp) do
      return { alert: "Invalid request.", status: 400 } unless valid_id?(id)
      store = Store.find_by_id(id)
      return { alert: "Store not found.", status: 404 } unless store
      raise ActiveRecord::RecordInvalid.new(store) unless store.update_attributes(params)
      store.update_attributes(params)
    end
  end

  def self.delete(id)
    success_resp = { notice: "Store deleted!" }
    transacional(success_resp) do
      return { alert: "Invalid request.", status: 400 } unless valid_id?(id)
      store = Store.find_by_id(id)
      return { alert: "Store not found.", status: 404 } unless store
      raise ActiveRecord::RecordInvalid.new(store) unless store.deactivate()
    end
  end
end
