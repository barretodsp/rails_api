class ApplicationService
  def self.transacional(success_message)
    ActiveRecord::Base.transaction do
      yield
    end
    success_message
  rescue ActiveRecord::RecordInvalid => exception
    { alert: exception.record.errors.full_messages }
  rescue Exception => e
    { alert: e.message }
  end
end
