class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something useful here
    # For example: send an email, process data, call an API, etc.
    Rails.logger.info "ExampleJob executed with args: #{args.inspect}"
  end
end
