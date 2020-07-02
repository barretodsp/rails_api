class ApplicationService
  def self.transacional(success_message)
    ActiveRecord::Base.transaction do
      yield
    end
    success_message
  rescue ActiveRecord::RecordInvalid => exception
    { alert: exception.record.errors.values.join(", "), status: 400 }
  rescue Exception => e
    { alert: e.message }
  end

  private

  def self.valid_id?(id)
    return true if id && id.to_s.match(/^[0-9]*$/)
    false
  end
end
