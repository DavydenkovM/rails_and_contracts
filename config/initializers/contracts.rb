# Contract.override_failure_callback do |data|
#   e = failure_message(data)

#   Rails.logger.error "Contract violation \n\t #{e}"
#   # Airbrake.notify_or_ignore(e)
# end

# def failure_message(data)
#   data
#   # StandardError.new(data)
# end
